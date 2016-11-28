json.extract! app, :id, :name, :api_key, :api_secret, :created_at, :updated_at
json.url app_url(app, format: :json)