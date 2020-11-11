class DeforceJob < ApplicationJob
  queue_as :default

  def perform
    @rate = Rate.actual
    DataServices::RatePublish.call @rate.value unless @rate.nil?
  end
end
