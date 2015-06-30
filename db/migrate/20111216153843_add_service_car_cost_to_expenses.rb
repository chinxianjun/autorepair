class AddServiceCarCostToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :service_car_cost, :float
  end
end
