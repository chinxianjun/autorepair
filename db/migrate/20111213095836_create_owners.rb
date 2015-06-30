class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :fullname
      t.string :phone
      t.string :address
      t.string :idcard

      t.timestamps
    end
  end
end
