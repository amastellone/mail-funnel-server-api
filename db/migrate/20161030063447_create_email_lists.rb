class CreateEmailLists < ActiveRecord::Migration[5.0]
  def change
    create_table :email_lists do |t|
      t.references :app_uuid, foreign_key: true
      t.integer :user_local_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
