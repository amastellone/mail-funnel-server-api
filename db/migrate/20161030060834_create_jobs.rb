class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.references :time, foreign_key: true
      t.string :subject
      t.text :content
      t.references :email_list_uuid, foreign_key: true
      t.references :app_uuid, foreign_key: true
      t.references :hook_uuid, foreign_key: true
      t.integer :user_local_id

      t.timestamps
    end
  end
end
