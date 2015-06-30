class CreateVehicleOwnerships < ActiveRecord::Migration
  def change
    create_table :vehicle_ownerships do |t|
      t.integer :vehicle_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
