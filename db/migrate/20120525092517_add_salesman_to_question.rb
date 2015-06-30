class AddSalesmanToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :salesman, :string
  end
end
