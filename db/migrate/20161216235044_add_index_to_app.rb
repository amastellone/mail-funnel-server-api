class AddIndexToApp < ActiveRecord::Migration[5.0]
  def change
    add_index :apps, :name, unique: true
  end
end
