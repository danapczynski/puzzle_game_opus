class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user
      t.references :level
      t.integer :completion_time
      t.timestamps
    end
  end
end
