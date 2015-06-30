class AddPropertyToDispatchings < ActiveRecord::Migration
  def change
    add_column :dispatchings, :property, :string
  end
end
