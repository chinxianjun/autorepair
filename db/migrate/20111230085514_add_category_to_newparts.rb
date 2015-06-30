class AddCategoryToNewparts < ActiveRecord::Migration
  def change
    add_column :newparts, :category, :string
  end
end
