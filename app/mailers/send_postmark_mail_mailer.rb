class SendPostmarkMailMailer < ActionMailer::Base

	def send_postmark(*args)
		list = EmailList.where(app_id: app_id, id: email_list_id).first

		list.emails.each do |email|

			# TODO: Create Documentation for adding dynamic datat to email.content (Jobs email content)
			content = ''
			content = email_content.gsub! '{$mf_recipient_name$}', email.name
			content = content.gsub! '{$mf_recipient_email$}', email.email_address

			content = "This is an email sent to: " + email.email_address + " / Name: " + email.name + " / With Content: " + content;

			# POSTMARK API

			# Postmark API
			mail(
				 :subject     => email_subject,
				 :to          => 'vas.kaloidis@gmail.com',
				 :from        => 'admin@mailfunnels.com',
				 :html_body   => content,
				 :tag     => 'my-tag',
				 :track_opens => 'true')

			# :to          => email.email_address,
			#  :tag     => email_list_id,
			#  :track_opens => 'true'

			# Update Job Record
			job              = Job.find(job_id)
			job.executed     = true
			job.execute_date = now
			job.save

			# AUDIT

			# Audit each email
			JobAudit.create(job_id:        job_id, app_id: app_id,
			                subject:       email_subject, content: content,
			                email_list_id: email_list_id, time_sent: Time.now,
			                recipient:     email.email_address)

		end
	end

end
