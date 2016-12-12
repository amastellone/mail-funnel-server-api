class App < ApplicationRecord
	validates_uniqueness_of :name
  validates_presence_of :name


	has_many :jobs
	has_many :emails
	has_many :email_lists
end
