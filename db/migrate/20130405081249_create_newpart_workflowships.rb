class CreateNewpartWorkflowships < ActiveRecord::Migration
  def change
    create_table :newpart_workflowships do |t|
      t.integer :newpart_id
      t.integer :workflow_id
      t.timestamps
    end
  end
end
