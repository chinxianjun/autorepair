class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :chassis_number
      t.string :engine
      t.string :engine_number

      t.timestamps
    end
  end
end
