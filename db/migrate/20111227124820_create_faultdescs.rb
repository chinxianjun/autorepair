class CreateFaultdescs < ActiveRecord::Migration
  def change
    create_table :faultdescs do |t|
      t.string :car_number
      t.text :description
      t.string :place

      t.timestamps
    end
  end
end
