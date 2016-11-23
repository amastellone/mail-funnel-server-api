class CreateConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :configs do |conf|
      conf.string :name
      conf.string :value

      conf.timestamps
    end
  end
end
