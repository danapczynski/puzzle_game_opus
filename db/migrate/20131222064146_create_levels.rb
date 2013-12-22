class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :completion_time
      t.timestamps
    end
  end
end
