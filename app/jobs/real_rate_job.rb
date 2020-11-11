class RealRateJob < ApplicationJob
  queue_as :default
  retry_on DataServices::RealRate::RateSiteError, wait: 10.minutes, attempts: 100

  def perform
    DataServices::RealRate.create
  end
end
