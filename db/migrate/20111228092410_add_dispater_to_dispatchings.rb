class AddDispaterToDispatchings < ActiveRecord::Migration
  def change
    add_column :dispatchings, :customer_name, :string
    add_column :dispatchings, :customer_phone, :string
    add_column :dispatchings, :customer_phone_swap, :string
    add_column :dispatchings, :faultdesc_desc, :text
    add_column :dispatchings, :faultdesc_place, :string
    add_column :dispatchings, :faultdesc_car_number, :string
  end
end
