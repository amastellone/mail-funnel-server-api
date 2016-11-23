class AddAppToEmails < ActiveRecord::Migration[5.0]
  def change
    add_reference :emails, :app, foreign_key: true

    add_reference :emails, :email_list, foreign_key: true
  end
end
