class AddFaultDescToFaults < ActiveRecord::Migration
  def change
    add_column :faults, :fault_desc, :text
  end
end
