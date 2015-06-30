class CreateOldpartWorkflowships < ActiveRecord::Migration
  def change
    create_table :oldpart_workflowships do |t|
      t.integer :oldpart_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
