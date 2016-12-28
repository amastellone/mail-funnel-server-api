class AddAppIdToJobAudits < ActiveRecord::Migration[5.0]
  def change
    add_reference :job_audits, :app, foreign_key: true
  end
end
