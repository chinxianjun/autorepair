class AddAgeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :age, :integer
  end
end
