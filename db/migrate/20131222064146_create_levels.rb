class CreateLevels < ActiveRecord::Migration[4.2]
  def change
    create_table :levels do |t|
      t.timestamps
    end
  end
end
