class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :nickname
      t.string :link_to_shape
      t.timestamps
    end
  end
end
