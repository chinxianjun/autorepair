class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|

      t.float :service_car_cost
      t.float :working_hours_cost
      t.float :material_cost
      t.float :total
      t.string :creator
      t.timestamps
    end
  end
end
