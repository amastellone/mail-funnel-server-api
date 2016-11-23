class AddReferencesToJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :jobs, :email_list, foreign_key: true

    add_reference :jobs, :app, foreign_key: true

    add_reference :jobs, :hook, foreign_key: true
  end
end
