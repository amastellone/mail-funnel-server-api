class Job < ApplicationRecord
  belongs_to :time
  belongs_to :email_list_uuid
  belongs_to :app_uuid
  belongs_to :hook_uuid
end
