class AddFullnameToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :fullname, :string
    add_column :vehicles, :phone, :string
    add_column :vehicles, :idcard, :string
    add_column :vehicles, :address, :string
  end
end
