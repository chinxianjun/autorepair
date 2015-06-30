class CreateFaultdescWorkflowships < ActiveRecord::Migration
  def change
    create_table :faultdesc_workflowships do |t|
      t.integer :faultdesc_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
