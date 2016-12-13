class AddAuthTokenToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :auth_token, :string
    add_index :apps, :auth_token, unique: true
  end
end
