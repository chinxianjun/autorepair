class AddFollowToWarehouse < ActiveRecord::Migration
  def change
    add_column :warehouses, :follows, :text
  end
end
