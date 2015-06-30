class CreateFaultdescCustomers < ActiveRecord::Migration
  def change
    create_table :faultdesc_customers do |t|
      t.integer :faultdesc_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
