class AddCategoryToIndirectparts < ActiveRecord::Migration
  def change
    add_column :indirectparts, :category, :string
  end
end
