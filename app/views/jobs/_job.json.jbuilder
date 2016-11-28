json.extract! job, :id, :time_id, :subject, :content, :email_list_uuid_id, :app_uuid_id, :hook_uuid_id, :user_local_id, :created_at, :updated_at
json.url job_url(job, format: :json)