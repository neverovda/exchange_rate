class Rate < ApplicationRecord
  validates :value, presence: true
  validates_numericality_of :value, greater_than: 0
  validate :expiration_at_cant_be_earlier_than_now, on: :create

  default_scope { order('created_at') }

  class << self
    def forced?
      !actual_forced_last.nil?
    end

    def forced_last
      where({ forced: true }).last
    end

    def actual
      actual_forced_last || real_last
    end

    private

    def real_last
      where({ forced: false }).last
    end

    def actual_forced_last
      where({ forced: true }).where('expiration_at > ?', Time.now).last
    end
  end

  private

  # validate
  def expiration_at_cant_be_earlier_than_now
    return if expiration_at.blank? || expiration_at > Time.now

    errors.add(:expiration_at, "can't be earlier than now")
  end
end
