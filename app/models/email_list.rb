class EmailList < ApplicationRecord
	validates :name, presence: true

	belongs_to :app
	belongs_to :campaign
	has_many :emails
end
