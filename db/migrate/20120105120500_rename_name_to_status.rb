class RenameNameToStatus < ActiveRecord::Migration
  def change
    rename_column :repairers, :name, :status
  end
end