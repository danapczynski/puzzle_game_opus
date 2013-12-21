class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
