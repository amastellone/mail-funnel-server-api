class SendEmailJob < ApplicationJob
  @queue = :default

  def perform(*args)

    list = EmailList.where(app_id: app_id, id: email_list_id).first

    list.emails.each do |email|

      # TODO: Create Documentation for adding dynamic datat to email.content (Jobs email content)
      content = ''
      content = email_content.gsub! '{$mf_recipient_name$}', email.name
      content = content.gsub! '{$mf_recipient_email$}', email.email_address

      # POSTMARK API

      # Postmark API
      # mail( # TODO: Enable + Test Postmark API
      # 	 :subject     => email_subject,
      # 	 :to          => email.email_address,
      # 	 :from        => 'sender@mailfunnels.com',
      # 	 :html_body   => email_content,
      # 	 :track_opens => 'true')

      # Postmark API - Development
      logger.info "WORKER EMAIL SENT - "


      # AUDIT

      # Audit each email
      JobAudit.create(job_id: job_id, app_id: app_id,
                      subject: email_subject, content: content,
                      email_list_id: email_list_id, time_sent: Time.now,
                      recipient: email.email_address)

    end

  end

end