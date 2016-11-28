class AddExecuteTimeToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :execute_time, :integer
  end
end
