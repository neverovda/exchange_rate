class RateCheckJob < ApplicationJob
  queue_as :default

  def perform
    return if Rate.forced?

    current_rate = Rate.real_last
    return unless current_rate

    ActionCable.server.broadcast 'rates', current_rate.price
  end
end
