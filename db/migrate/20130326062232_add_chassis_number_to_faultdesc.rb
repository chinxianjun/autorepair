class AddChassisNumberToFaultdesc < ActiveRecord::Migration
  def change
    add_column  :faultdescs, :chassis_number, :string
    add_column  :faultdescs, :driving_range, :float
    add_column  :faultdescs, :model,  :string
    add_column  :faultdescs, :purchase_on, :date
  end
end
