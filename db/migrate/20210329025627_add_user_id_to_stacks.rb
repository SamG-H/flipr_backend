class AddUserIdToStacks < ActiveRecord::Migration[6.0]
  def change
    add_reference :stacks, :user 
  end
end
