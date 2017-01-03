class Email < ApplicationRecord
	validates :email_address, presence: { strict: true }

	belongs_to :email_list
	belongs_to :app
end
