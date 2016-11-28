json.extract! job, :id, :created_at, :updated_at, :frequency, :execute_time,
              :subject, :content,
              :email_list_id, :app_id,
              :hook_identifier, :executed,
              :campaign_identifier
json.url job_url(job, format: :json)