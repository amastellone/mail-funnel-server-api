class EmailList < ApplicationRecord
	validates :name, presence: true

	has_one :app
	has_many :emails
	has_one :job
end
