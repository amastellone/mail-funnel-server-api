class JobAuditSerializer < ActiveModel::Serializer
  attributes :id, :time_sent, :recipient, :subject, :content
  has_one :job
end
