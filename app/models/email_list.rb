class EmailList < ApplicationRecord
  validates :name, presence: true

  belongs_to :apps
  has_many   :emails
  has_one    :job
end
