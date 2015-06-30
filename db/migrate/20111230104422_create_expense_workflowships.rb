class CreateExpenseWorkflowships < ActiveRecord::Migration
  def change
    create_table :expense_workflowships do |t|
      t.integer :expense_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
