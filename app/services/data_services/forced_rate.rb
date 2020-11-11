class DataServices::ForcedRate
  def self.create(params)
    new(params)._save
  end

  def initialize(params)
    @rate = Rate.new(params)
    @rate.forced = true
  end

  def _save
    ActiveRecord::Base.transaction do
      @rate.save!
      delete_deforce_jobs
      DataServices::RatePublish.call @rate.value
      create_deforcing_job
    end
    @rate
  rescue ActiveRecord::RecordInvalid
    @rate
  end

  private

  def delete_deforce_jobs
    queue = Sidekiq::ScheduledSet.new
    queue.each { |job| job.delete if job.args[0]['job_class'] == 'DeforceJob' }
  end

  def create_deforcing_job
    DeforceJob.set(wait_until: @rate.expiration_at).perform_later
  end
end
