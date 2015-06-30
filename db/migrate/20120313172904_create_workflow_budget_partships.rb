class CreateWorkflowBudgetPartships < ActiveRecord::Migration
  def change
    create_table :workflow_budget_partships do |t|
      t.integer :workflow_id
      t.integer :budget_part_id
      t.timestamps
    end
  end
end
