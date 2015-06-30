class CreateFaultWorkflowships < ActiveRecord::Migration
  def change
    create_table :fault_workflowships do |t|
      t.integer :fault_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
