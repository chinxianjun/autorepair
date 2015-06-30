class RenameFaultTypeToFaults < ActiveRecord::Migration
  def change
    rename_column :faults, :fault_type, :measure
  end
end
