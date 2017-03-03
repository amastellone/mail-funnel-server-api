class AddExecuteSetTime < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :execute_set_time, :datetime
  end
end
