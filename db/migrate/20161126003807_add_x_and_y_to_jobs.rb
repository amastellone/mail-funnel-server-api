class AddXAndYToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :x, :float
    add_column :jobs, :y, :float
  end
end
