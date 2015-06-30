class AddOldpartManagerToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :oldpart_manager, :string
    add_column :newparts, :newpart_manager, :string
    add_column :expenses, :info_worker, :string
  end
end
