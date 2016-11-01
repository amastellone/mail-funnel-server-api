class API < Grape::API
  prefix 'api'
  format :json
  mount MailFunnel::Api
  # mount MailFunnel::Raise
  # mount MailFunnel::Protected
  # mount MailFunnel::Post
end