class AddClassesToOldparts < ActiveRecord::Migration
  def change
    add_column :oldparts, :classes, :string
    add_column :indirectparts, :classes, :string
  end
end
