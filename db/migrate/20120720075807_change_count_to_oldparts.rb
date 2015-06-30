class ChangeCountToOldparts < ActiveRecord::Migration
  def change
    #rename_column :oldparts, :count, :price
    add_column :oldparts, :price, :float
    add_column :oldparts, :fault_info, :text
  end
end
