class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :frequency
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
