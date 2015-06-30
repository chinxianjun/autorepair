class AddParentIdToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :parent_id, :integer
  end
end
