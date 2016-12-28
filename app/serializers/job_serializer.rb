class JobSerializer < ActiveModel::Serializer
	attributes :id, :subject, :content, :email_list_id, :app_id, :client_campaign, :executed, :execute_time, :execute_frequency, :hook_identifier, :name

	belongs_to :apps
	# has_many :job_audit
	has_one :email_list_id
	class EmailListSerializer < ActiveModel::Serializer
		attributes :id, :name, :description, :app_id
	end
end
