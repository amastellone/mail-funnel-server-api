class RemoveApiKeyAndApiSecretFromApps < ActiveRecord::Migration[5.0]
  def change
    # remove_column :table_name, :column_name
    remove_column :jobs, :x
    remove_column :jobs, :y
    remove_column :jobs, :frequency
    add_column :jobs, :execute_frequency, :string
  end
end
