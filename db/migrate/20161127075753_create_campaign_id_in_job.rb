class CreateCampaignIdInJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :campaign_identifier, :integer
  end
end
