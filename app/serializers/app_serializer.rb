class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key

  type 'app'

  has_many :jobs
  has_many :emails
  has_many :email_lists
end
