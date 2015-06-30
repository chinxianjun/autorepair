class CreateUserWarehouseships < ActiveRecord::Migration
  def change
    create_table :user_warehouseships do |t|
      t.integer :user_id
      t.integer :warehouse_id
      t.timestamps
    end
  end
end
