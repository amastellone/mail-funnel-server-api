class SendEmailJob
  @queue = :default

  def test_email(subject, to, from, html_body, track_opens, email_list_name)
    logger.debug "EMAIL SENT - List: " + email_list_name + " To: " + to + " Email Subject + Content: " + subject + " - " + html_body
  end

  def self.perform(job_id, app_id, email_list_id, email_subject, email_content)

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
      test_email(email_subject, email.email_address, 'sender@mailfunnels.com', email_content, 'true', list.name)


      # AUDIT

      # Audit each email
      JobAudit.create(job_id: job_id, app_id: app_id,
                      subject: email_subject, content: content,
                      email_list_id: email_list_id, time_sent: Time.now,
                      recipient: email.email_address)

    end

  end

end