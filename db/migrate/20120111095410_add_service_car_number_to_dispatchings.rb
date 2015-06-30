class AddServiceCarNumberToDispatchings < ActiveRecord::Migration
  def change
    add_column :dispatchings, :service_car_number, :string
  end
end
