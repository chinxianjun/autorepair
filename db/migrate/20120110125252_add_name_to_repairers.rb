class AddNameToRepairers < ActiveRecord::Migration
  def change
    add_column :repairers, :name, :string
  end
end
