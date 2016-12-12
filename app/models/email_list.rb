class EmailList < ApplicationRecord
  belongs_to :apps
  has_many   :emails
  has_one    :job
end
