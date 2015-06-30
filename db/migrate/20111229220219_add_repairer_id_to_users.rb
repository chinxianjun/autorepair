class AddRepairerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :repairer_id, :integer
  end
end
