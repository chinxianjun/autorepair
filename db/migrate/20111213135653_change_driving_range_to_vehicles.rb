class ChangeDrivingRangeToVehicles < ActiveRecord::Migration
  def change
    change_column :vehicles, :driving_range, :string
  end
end
