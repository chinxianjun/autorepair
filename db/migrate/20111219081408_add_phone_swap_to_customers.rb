class AddPhoneSwapToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :phone_swap, :string
  end
end
