require 'rails_helper'

RSpec.describe RealRateJob, type: :job do
  it 'calls DataServices::RealRate#create' do
    expect(DataServices::RealRate).to receive(:create)
    RealRateJob.perform_now
  end
end
