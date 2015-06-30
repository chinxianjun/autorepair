class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :username
      t.string :gender
      t.string :phone
      t.string :address
      t.date :birthday

      t.timestamps
    end
  end
end
