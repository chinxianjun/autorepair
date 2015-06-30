class AddFastTypeToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :order_number, :string
    add_column :vehicles, :fast_type, :string
    add_column :vehicles, :production_number, :string
    add_column :vehicles, :first_bridge, :string
    add_column :vehicles, :second_bridge, :string
    add_column :vehicles, :third_bridge, :string
    add_column :vehicles, :driving_range, :float
    add_column :vehicles, :purchase_on, :datetime
    add_column :vehicles, :warranty_card, :string
    add_column :vehicles, :user_number, :string
  end
end
