class AddHomePageToWarehouses < ActiveRecord::Migration
  def change
    add_column :warehouses, :identifier, :string, :limit => 20
    add_column :warehouses, :homepage, :string
  end
end
