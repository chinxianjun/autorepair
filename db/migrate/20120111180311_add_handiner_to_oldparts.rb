class AddHandinerToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :handiner, :string
    add_column :indirectparts, :handiner, :string
    add_column :indirectparts, :oldpart_manager, :string
    add_column :newparts, :receiver, :string
  end
end
