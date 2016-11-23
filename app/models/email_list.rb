class EmailList < ApplicationRecord
  belongs_to :apps
  has_many   :emails
end
