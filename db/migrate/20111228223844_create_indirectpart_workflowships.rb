class CreateIndirectpartWorkflowships < ActiveRecord::Migration
  def change
    create_table :indirectpart_workflowships do |t|
      t.integer :indirect_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
