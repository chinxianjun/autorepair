class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.string :category
      t.string :name
      t.string :drawing
      t.string :price
      t.integer :count
      t.string :factory
      t.string :factory_code
      t.timestamps
    end
  end
end
