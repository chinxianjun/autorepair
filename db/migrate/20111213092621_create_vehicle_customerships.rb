class CreateVehicleCustomerships < ActiveRecord::Migration
  def change
    create_table :vehicle_customerships do |t|
      t.integer :vehicle_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
