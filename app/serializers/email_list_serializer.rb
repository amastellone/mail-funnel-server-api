class EmailListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :emails
end
