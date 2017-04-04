class AddSourceToCampaignProductLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :campaign_product_leads, :Source, :string
  end
end
