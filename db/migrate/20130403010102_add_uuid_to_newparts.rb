class AddUuidToNewparts < ActiveRecord::Migration
  def change
    add_column :newparts, :uuid, :string
  end
end
