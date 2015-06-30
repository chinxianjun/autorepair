class AddTotalToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :total, :float
  end
end
