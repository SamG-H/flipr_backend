class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.text :name
      t.integer :percentage
      t.integer :stack_id

      t.timestamps
    end
  end
end
