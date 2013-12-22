class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :nickname
      t.text :shape
      t.timestamps
    end
  end
end
