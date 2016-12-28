class EmailList < ApplicationRecord
	validates :name, presence: true

	has_one :apps
	has_many :emails
end
