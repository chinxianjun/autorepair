class CreateRoleWarehouseships < ActiveRecord::Migration
  def change
    create_table :role_warehouseships do |t|
      t.integer :role_id
      t.integer :warehouse_id
      t.timestamps
    end
  end
end
