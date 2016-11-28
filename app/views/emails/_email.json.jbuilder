json.extract! email, :id, :email, :name, :email_list_id, :app_id, :created_at, :updated_at
json.url email_url(email, format: :json)