class AddBuilderLockedToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :builder_locked, :boolean, default: false
  end
end