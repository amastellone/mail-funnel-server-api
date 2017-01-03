class CreateMfServerConfig < ActiveRecord::Migration[5.0]
  def change
    create_table :mf_server_config do |t|
      t.string :name
      t.string :value
    end
    add_index :mf_server_config, :name
  end
end
