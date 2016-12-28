class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :builder_lock, :auth_token

  has_many :jobs
  has_many :email_lists
  # has_many :job_audits
end
