class AddEmailListIdToJobAudits < ActiveRecord::Migration[5.0]
  def change
    add_reference :job_audits, :email_list, foreign_key: true
  end
end
