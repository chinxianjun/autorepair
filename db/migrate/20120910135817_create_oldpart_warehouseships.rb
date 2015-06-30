class CreateOldpartWarehouseships < ActiveRecord::Migration
  def change
    create_table :oldpart_warehouseships do |t|
      t.integer :oldpart_id
      t.integer :warehouse_id
      t.timestamps
    end
  end
end
