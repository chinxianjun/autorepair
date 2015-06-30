class AddRepairmanToWorkflows < ActiveRecord::Migration
  def change
    add_column :workflows, :repairman, :string
    add_column :workflows, :warranty, :string
  end
end
