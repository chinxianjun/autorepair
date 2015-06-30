class AddStatusToNewparts < ActiveRecord::Migration
  def change
    add_column :newparts, :status, :string
  end
end
