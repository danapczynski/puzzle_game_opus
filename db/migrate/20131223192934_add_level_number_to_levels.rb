class AddLevelNumberToLevels < ActiveRecord::Migration[4.2]
  def change
    add_column :levels, :level_number, :integer
  end
end
