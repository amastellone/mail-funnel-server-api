class ExecuteEmailJob < ApplicationJob
	queue_as :default

	def self.perform(app_id, email_list_id, email_subject, email_content)

		list = EmailList.where(app_id: app_id, id: email_list_id).first

		list.emails.each do |email|

			mail(
				 :subject     => email_subject,
				 :to          => email.email_address,
				 :from        => 'sender@mailfunnels.com',
				 :html_body   => email_content,
				 :track_opens => 'true')

		end

	end
end