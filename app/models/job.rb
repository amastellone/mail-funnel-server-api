class Job < ApplicationRecord
  has_one :email_lists
  belongs_to :apps
  has_one :hooks
end
