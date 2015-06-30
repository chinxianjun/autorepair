class AddStatusToFault < ActiveRecord::Migration
  def change
    add_column :faults, :status, :string
  end
end
