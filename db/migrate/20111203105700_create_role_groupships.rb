class CreateRoleGroupships < ActiveRecord::Migration
  def change
    create_table :role_groupships do |t|
      t.integer :role_id
      t.integer :group_id
      t.timestamps
    end
    rg = RoleGroupship.create(:group_id => 1, :role_id => 1)
  end
end