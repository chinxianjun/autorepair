class AddWarrantyTofaultdescs < ActiveRecord::Migration
  def change
    add_column :faultdescs, :warranty, :string
  end
end
