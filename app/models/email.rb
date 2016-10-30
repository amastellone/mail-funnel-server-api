class Email < ApplicationRecord
  belongs_to :email_list_uuid
  belongs_to :app_uuid
end
