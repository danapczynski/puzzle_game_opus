class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.timestamps
    end
  end
end
