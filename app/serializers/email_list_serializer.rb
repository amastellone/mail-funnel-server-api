class EmailListSerializer < ActiveModel::Serializer
	attributes :id, :name, :description, :app_id

	has_many :emails
	class EmailSerializer < ActiveModel::Serializer
		attributes :id, :email_address, :name
	end
end
