class AddCarNumberToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :car_number, :string
  end
end
