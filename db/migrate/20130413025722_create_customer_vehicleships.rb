class CreateCustomerVehicleships < ActiveRecord::Migration
  def change
    create_table :customer_vehicleships do |t|
      t.integer :customer_id
      t.integer :vehicle_id
      t.timestamps
    end
  end
end
