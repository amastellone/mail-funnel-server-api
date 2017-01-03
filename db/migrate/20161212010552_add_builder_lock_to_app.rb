class AddBuilderLockToApp < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :builder_lock, :boolean, :default => false
  end
end
