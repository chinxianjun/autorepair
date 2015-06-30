class AddNeighborIdToWarehouses < ActiveRecord::Migration
  def change
    add_column :warehouses, :neighbor_ids, :text
  end
end
