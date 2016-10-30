json.extract! email_list, :id, :app_uuid_id, :user_local_id, :name, :description, :created_at, :updated_at
json.url email_list_url(email_list, format: :json)