class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :category
      t.text :description
      t.string :repair_number
      t.string :car_number
      t.string :defendant
      t.string :status

      t.timestamps
    end
  end
end
