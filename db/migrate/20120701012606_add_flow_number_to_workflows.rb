class AddFlowNumberToWorkflows < ActiveRecord::Migration
  def change
    add_column :workflows, :flow_number, :string
  end
end
