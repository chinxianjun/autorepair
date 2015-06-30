class CreateCompanyWorkflows < ActiveRecord::Migration
  def change
    create_table :company_workflows do |t|
      t.integer :company_id
      t.integer :workflow_id
      t.timestamps
    end
  end
end
