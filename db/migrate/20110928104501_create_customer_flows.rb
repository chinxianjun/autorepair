class CreateCustomerFlows < ActiveRecord::Migration
  def change
    create_table :customer_flows do |t|
      t.string :username
      t.string :gender
      t.string :phone
      t.string :email
      t.string :address
      t.string :zipcode
      t.datetime :birthday

      t.timestamps
    end
  end
end
