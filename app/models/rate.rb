class Rate < ApplicationRecord
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0
  validate :expiration_at_cant_be_earlier_than_now, on: :create

  default_scope { order('created_at') }

  after_create :publish, :check_rate

  class << self
    def forced?
      !actual_forced_last.nil?
    end

    def real_last
      where({ forced: false }).last
    end

    def forced_last
      where({ forced: true }).last
    end

    def actual
      actual_forced_last || real_last
    end

    private

    def actual_forced_last
      where({ forced: true }).where('expiration_at > ?', Time.now).last
    end
  end

  private

  def publish
    ActionCable.server.broadcast 'rates', price
  end

  def check_rate
    RateCheckJob.set(wait_until: expiration_at).perform_later if forced
  end

  def expiration_at_cant_be_earlier_than_now
    return if expiration_at.blank? || expiration_at > Time.now

    errors.add(:expiration_at, "can't be earlier than now")
  end
end
