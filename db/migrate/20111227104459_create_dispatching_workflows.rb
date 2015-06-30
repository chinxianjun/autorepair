class CreateDispatchingWorkflows < ActiveRecord::Migration
  def change
    create_table :dispatching_workflows do |t|
      t.integer :dispatching_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
