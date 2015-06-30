class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :category
      t.string :manager
      t.integer :parent_id
      t.text :description
      t.timestamps
    end
  end
end
