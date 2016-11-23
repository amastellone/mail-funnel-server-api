class Job < ApplicationRecord
  belongs_to :email_lists
  belongs_to :apps
  belongs_to :hooks
end
