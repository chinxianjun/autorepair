class AddCategoryToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :category, :string
  end
end
