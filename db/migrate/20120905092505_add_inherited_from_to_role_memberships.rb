class AddInheritedFromToRoleMemberships < ActiveRecord::Migration
  def change
    add_column :role_memberships, :inherited_from, :integer
  end
end
