class RealRateJob < ApplicationJob
  queue_as :default

  def perform
    DataServices::RealRate.create
  end
end
