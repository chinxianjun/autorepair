class RenameFaultInfoToOldparts < ActiveRecord::Migration
  def change
    rename_column :oldparts, :fault_info, :note
  end
end
