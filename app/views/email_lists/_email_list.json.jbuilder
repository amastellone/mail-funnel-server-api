json.extract! email_list, :id, :app_id, :name, :description, :created_at, :updated_at
json.url email_list_url(email_list, format: :json)