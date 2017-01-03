class RenameEmailsEmailToAddress < ActiveRecord::Migration[5.0]
  def change
    rename_column :emails, :email, :email_address
  end
end
