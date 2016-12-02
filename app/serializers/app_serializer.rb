class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key

  has_many :jobs
  has_many :email_lists
end
