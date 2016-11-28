class ChangeHookIdentifierToString < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :hook_id
    add_column    :jobs, :hook_identifier, :string
  end
end
