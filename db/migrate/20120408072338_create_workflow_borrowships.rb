class CreateWorkflowBorrowships < ActiveRecord::Migration
  def change
    create_table :workflow_borrowships do |t|
      t.integer :workflow_id
      t.integer :borrow_id
      t.timestamps
    end
  end
end
