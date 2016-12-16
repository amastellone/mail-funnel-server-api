class Email < ApplicationRecord
validates :email, presence: { strict: true }

  belongs_to :email_list
  belongs_to :app
end
