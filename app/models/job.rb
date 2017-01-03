class Job < ApplicationRecord
	has_one :email_lists
	belongs_to :apps
	has_one :hooks


	def queue_job(wait)
		# SendEmailJob.set(wait_until: wait).perform_later(self.id, self.app_id, self.email_list_id, self.content, self.subject)
		# Resque.enqueue_in(wait, self, self.id, self.app_id, self.email_list_id, self.content, self.subject)
	end

	def delete_job
		# Resque.remove_delayed(self, self.id, self.app_id, self.email_list_id, self.content, self.subject)
	end


end
