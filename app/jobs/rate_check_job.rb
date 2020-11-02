class RateCheckJob < ApplicationJob
  queue_as :default

  def perform
    #return if Rate.forced?

    current_rate = Rate.real_last
    # return unless current_rate

    Rails.cache.write('actual_rate_value', current_rate.value)
    ActionCable.server.broadcast 'rates', current_rate.value
  end
end
