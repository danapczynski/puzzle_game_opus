class CreateScores < ActiveRecord::Migration[4.2]
  def change
    create_table :scores do |t|
      t.references :user
      t.references :level
      t.integer :completion_time
      t.timestamps
    end
  end
end
