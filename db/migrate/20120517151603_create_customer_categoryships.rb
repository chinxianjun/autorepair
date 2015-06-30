class CreateCustomerCategoryships < ActiveRecord::Migration
  def change
    create_table :customer_categoryships do |t|
      t.integer :customer_id
      t.integer :category_id
      t.timestamps
    end
  end
end
