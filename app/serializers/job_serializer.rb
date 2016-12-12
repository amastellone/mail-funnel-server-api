class JobSerializer < ActiveModel::Serializer
	type 'job'

	attributes :id,
	           :frequency,
	           :subject,
	           :content,
	           :created_at,
	           :updated_at,
	           :email_list_id,
	           :app_id,
	           :client_campaign,
	           :campaign_identifier,
	           :executed,
	           :execute_time,
	           :hook_identifier


	belongs_to :apps
	has_one :email_list_id
	# has_one :hook_id
end
