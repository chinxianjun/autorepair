class AddRunningNumberToNewparts < ActiveRecord::Migration
  def change
    add_column :newparts, :running_number, :string
    add_column :newparts, :factory_code, :string
    add_column :newparts, :count, :integer
  end
end
