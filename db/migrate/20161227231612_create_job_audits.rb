class CreateJobAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :job_audits do |t|
      t.references :job, foreign_key: true
      t.datetime :time_sent, :null => false, :default => Time.now
      t.string :recipient
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
