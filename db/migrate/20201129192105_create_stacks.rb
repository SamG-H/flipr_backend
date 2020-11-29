class CreateStacks < ActiveRecord::Migration[6.0]
  def change
    create_table :stacks do |t|
      t.text :title

      t.timestamps
    end
  end
end
