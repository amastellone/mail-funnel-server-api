class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :name
      t.references :email_list_id, foreign_key: true
      t.references :app_id, foreign_key: true

      t.timestamps
    end
  end
end
