class Job < ApplicationRecord
  has_one :email_lists
  belongs_to :apps
  has_one :hooks
  has_many :job_audits

	def queue_job(wait)
		SendEmailJob.set(wait_until: wait_once).perform_later(@job.app_id, @job.email_list_id, @job.content, @job.subject)
	end

end
