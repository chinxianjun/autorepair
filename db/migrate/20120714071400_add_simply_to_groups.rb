class AddSimplyToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :simply, :string
  end
end
