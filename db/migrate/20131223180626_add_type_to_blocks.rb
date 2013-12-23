class AddTypeToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :type, :string
  end
end
