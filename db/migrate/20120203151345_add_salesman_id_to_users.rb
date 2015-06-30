class AddSalesmanIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salesman_id, :integer
  end
end
