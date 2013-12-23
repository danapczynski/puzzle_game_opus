class AddLevelNumberToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :level_number, :integer
  end
end
