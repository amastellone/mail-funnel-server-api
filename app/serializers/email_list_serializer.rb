class EmailListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  type 'email_list'

  has_many :emails
end
