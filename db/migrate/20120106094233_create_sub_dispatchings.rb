class CreateSubDispatchings < ActiveRecord::Migration
  def change
    create_table :sub_dispatchings do |t|
      t.string   :repairer
      t.string   :dispatcher
      t.string   :reception
      t.string   :status
      t.string   :customer_name
      t.string   :customer_phone
      t.string   :customer_phone_swap
      t.text     :faultdesc_desc
      t.string   :faultdesc_place
      t.string   :faultdesc_car_number
      t.string   :property
      t.string   :creator
      t.timestamps
    end
  end
end
