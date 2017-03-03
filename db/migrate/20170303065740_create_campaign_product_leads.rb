class CreateCampaignProductLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_product_leads do |t|
      t.references :app, foreign_key: true
      t.integer :product_identifier
      t.references :campaign, foreign_key: true
      t.references :job, foreign_key: true
      t.boolean :sold, default: false
      t.decimal :sale_ammount, default: 0.00
      t.references :email_list, foreign_key: true
      t.references :email, foreign_key: true
      t.datetime :BuyDate
      t.datetime :ClickDate

    end
  end
end
