class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.text :front
      t.text :back
      t.integer :stack_id

      t.timestamps
    end
  end
end
