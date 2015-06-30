class CreateVehicleWorkflowships < ActiveRecord::Migration
  def change
    create_table :vehicle_workflowships do |t|
      t.integer :vehicle_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
