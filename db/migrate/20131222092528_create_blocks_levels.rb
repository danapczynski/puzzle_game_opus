class CreateBlocksLevels < ActiveRecord::Migration
  def change
    create_table :blocks_levels do |t|
      t.references :block
      t.references :level
      t.timestamps
    end
  end
end
