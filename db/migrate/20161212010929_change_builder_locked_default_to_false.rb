class ChangeBuilderLockedDefaultToFalse < ActiveRecord::Migration[5.0]
  def change
    change_column :apps, :builder_lock, :boolean, :default => false
  end
end
