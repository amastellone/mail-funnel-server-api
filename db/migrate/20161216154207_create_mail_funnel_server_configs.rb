class CreateMailFunnelServerConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :mail_funnel_server_configs do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
