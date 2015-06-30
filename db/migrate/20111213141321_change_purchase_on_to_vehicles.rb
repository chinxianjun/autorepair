class ChangePurchaseOnToVehicles < ActiveRecord::Migration
  def change
    change_column :vehicles, :purchase_on, :date
  end
end
