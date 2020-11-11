RSpec.describe 'DataServices::ForcedRate' do
  describe '.create' do
    Sidekiq::Testing.disable!
    subject { DataServices::ForcedRate.create(params) }

    context 'with invalid params' do
      let(:params) { { value: -100.1111, expiration_at: Time.now - 1.hour } }

      it 'dont save rate' do
        expect { subject }.not_to change(Rate, :count)
      end

      it { should be_instance_of(Rate) }
    end

    context 'with valid params' do
      let(:params) { { value: 100.1111, expiration_at: Time.now + 1.hour } }

      it { should be_instance_of(Rate) }

      it 'should publish rate' do
        expect(DataServices::RatePublish).to receive(:call)
        subject
      end

      it 'should create DeforceJob' do
        ActiveJob::Base.queue_adapter = :test
        expect { subject }.to have_enqueued_job(DeforceJob)
      end

      it 'should delete deforce jobs and create one new job' do
        ActiveJob::Base.queue_adapter = :sidekiq
        DeforceJob.set(wait_until: Time.now + 1.hour).perform_later
        expect { subject }.not_to change(Sidekiq::ScheduledSet.new, :count)
      end

      it 'saves the rate' do
        expect { subject }.to change(Rate, :count).by(1)
      end
    end
  end
end
