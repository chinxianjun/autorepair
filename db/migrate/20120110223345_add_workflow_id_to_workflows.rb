class AddWorkflowIdToWorkflows < ActiveRecord::Migration
  def change
    add_column :workflows, :workflow_id, :string
  end
end
