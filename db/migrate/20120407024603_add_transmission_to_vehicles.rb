class AddTransmissionToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :transmission_number, :string
    add_column :vehicles, :front_transmission_drawing, :string
    add_column :vehicles, :front_transmission_code, :string
    add_column :vehicles, :back_transmission_drawing, :string
    add_column :vehicles, :back_transmission_code, :string
    add_column :vehicles, :tank_drawing, :string
    add_column :vehicles, :tank_code, :string
    add_column :vehicles, :spring_drawing, :string
    add_column :vehicles, :spring_code, :string
    add_column :vehicles, :workplace, :string
    add_column :vehicles, :gearbox_drawing, :string
    add_column :vehicles, :gearbox_type, :string
    add_column :owners, :workplace, :string
  end
end
