class AddCategoryToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :category, :string
    add_column :budgets, :name, :string
    add_column :budgets, :drawing, :string
    add_column :budgets, :count, :integer
    add_column :budgets, :price, :float
    add_column :budgets, :factory, :string
    add_column :budgets, :factory_code, :string
    add_column :budgets, :three_bags, :string
  end
end
