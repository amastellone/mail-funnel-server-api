class Email < ApplicationRecord
  belongs_to :email_list
  belongs_to :app
end
