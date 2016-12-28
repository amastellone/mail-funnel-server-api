class EmailSerializer < ActiveModel::Serializer
	attributes :id, :email_address, :name, :app_id, :email_list_id

	belongs_to :email_list
	belongs_to :app
end
