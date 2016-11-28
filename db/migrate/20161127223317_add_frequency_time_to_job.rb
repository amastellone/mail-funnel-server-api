class AddFrequencyTimeToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :frequency_time, :time
    add_column :jobs, :executed, :boolean
  end
end
