class AddFirstDriveShaftCodeToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :first_drive_shaft_code, :string
    rename_column :vehicles, :transmission_number, :first_drive_shaft_drawing
    rename_column :vehicles, :front_transmission_drawing, :second_drive_shaft_drawing
    rename_column :vehicles, :front_transmission_code, :second_drive_shaft_code
    rename_column :vehicles, :back_transmission_drawing, :third_drive_shaft_drawing
    rename_column :vehicles, :back_transmission_code, :third_drive_shaft_code
  end
end
