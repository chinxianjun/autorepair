class CreateCustomerWorkflows < ActiveRecord::Migration
  def change
    create_table :customer_workflows do |t|
      t.integer :customer_id
      t.integer :workflow_id
      t.timestamps
    end
  end
end
