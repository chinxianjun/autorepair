class AddUuidToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :uuid, :string, :primary => true
  end
end
