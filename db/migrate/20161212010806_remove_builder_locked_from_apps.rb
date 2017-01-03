class RemoveBuilderLockedFromApps < ActiveRecord::Migration[5.0]
  def change
    remove_column :apps, :BuilderLocked
  end
end
