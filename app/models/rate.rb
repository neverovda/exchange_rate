class Rate < ApplicationRecord
  after_create

  # after_create :publish, :check_rate
  after_create :check_rate

  class << self
    def forced?
      !forced_last.nil?
    end

    def real_last
      where({ forced: false }).order('created_at').last
    end

    private

    def forced_last
      where({ forced: true }).where('expiration_at > ?', Time.now)
                             .order('created_at').last
    end
  end

  private

  def publish
    ActionCable.server.broadcast 'rates', price
  end

  def check_rate
    RateCheckJob.set(wait_until: expiration_at).perform_later if forced
  end
end
