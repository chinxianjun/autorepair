class AddLftToWarehouses < ActiveRecord::Migration
  def change
    add_column :warehouses, :lft, :integer
    add_column :warehouses, :rgt, :integer
  end
end
