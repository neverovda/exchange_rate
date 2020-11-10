require 'rails_helper'

RSpec.describe DeforceJob, type: :job do
  it 'calls DataServices::DataServices::RatePublish#call' do
    create(:rate)
    expect(DataServices::RatePublish).to receive(:call)
    RealRateJob.perform_now
  end
end