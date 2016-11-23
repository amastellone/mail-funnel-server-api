class Email < ApplicationRecord
  belongs_to :email_lists
  belongs_to :apps
end
