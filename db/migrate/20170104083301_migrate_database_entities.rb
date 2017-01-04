class MigrateDatabaseEntities < ActiveRecord::Migration[5.0]
  def change
    remove_column :apps, :api_key
    remove_column :apps, :api_secret
    remove_column :apps, :builder_locked
    remove_column :apps, :builder_lock
    add_column :jobs, :execute_date, :datetime
    remove_column :jobs, :campaign_identifier
  end
end
