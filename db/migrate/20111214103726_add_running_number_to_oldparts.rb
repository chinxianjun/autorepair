class AddRunningNumberToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :running_number, :string
    add_column :oldparts, :category, :string
    add_column :oldparts, :factory_code, :string
    add_column :oldparts, :fault_desc, :string
  end
end
