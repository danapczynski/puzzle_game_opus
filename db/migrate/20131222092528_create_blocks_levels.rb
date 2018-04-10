class CreateBlocksLevels < ActiveRecord::Migration[4.2]
  def change
    create_table :blocks_levels, :id => false, :force => true do |t|
      t.references :block
      t.references :level
    end
  end
end
