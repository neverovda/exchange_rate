class Rate < ApplicationRecord
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
end
