class CreateDispatchingBudgetships < ActiveRecord::Migration
  def change
    create_table :dispatching_budgetships do |t|
      t.integer :dispatching_id
      t.integer :budget_id
      t.timestamps
    end
  end
end
