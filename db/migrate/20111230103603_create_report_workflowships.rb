class CreateReportWorkflowships < ActiveRecord::Migration
  def change
    create_table :report_workflowships do |t|
      t.integer :report_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
