class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      # t.integer :user_local_id
      t.string :name
      t.string :api_key
      t.text :api_secret

      t.timestamps
    end
  end
end
