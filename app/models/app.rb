class App < ApplicationRecord

	has_many :jobs
	has_many :email_lists
end
