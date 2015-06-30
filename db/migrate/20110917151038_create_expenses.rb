class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.float :material_cost
      t.float :working_hours_cost
      t.float :communication_cost
      t.float :service_cat_cost
      t.float :meal_cost
      t.float :travel_expense

      t.timestamps
    end
  end
end
