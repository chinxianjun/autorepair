class CreateRoleMemberships < ActiveRecord::Migration
  def change
    create_table :role_memberships do |t|
      t.integer :role_id
      t.integer :member_id
      t.timestamps
    end
  end
end
