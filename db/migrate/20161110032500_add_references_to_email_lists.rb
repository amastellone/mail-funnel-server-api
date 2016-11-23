class AddReferencesToEmailLists < ActiveRecord::Migration[5.0]
  def change
    add_reference :email_lists, :app, foreign_key: true
  end
end
