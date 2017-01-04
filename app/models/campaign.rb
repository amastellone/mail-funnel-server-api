class Campaign < ApplicationRecord
	has_one :hook
	has_many :jobs
	has_one :email_list
	belongs_to :app

	# accepts_nested_attributes_for :hooks
end
