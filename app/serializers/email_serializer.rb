class EmailSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :app_id, :email_list_id

  belongs_to :email_list_id
  # belongs_to :app_id
end
