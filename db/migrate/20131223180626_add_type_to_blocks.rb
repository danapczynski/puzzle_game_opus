class AddTypeToBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :blocks, :type, :string
  end
end
