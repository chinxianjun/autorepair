class AddStatusToDispatchings < ActiveRecord::Migration
  def change
    add_column :dispatchings, :status, :string
  end
end
