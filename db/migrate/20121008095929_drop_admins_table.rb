class DropAdminsTable < ActiveRecord::Migration
  def up
    drop_table :admins
    drop_table :admin_profileships
    drop_table :admin_companyships
    drop_table :oldparthouses
    drop_table :newparthouses
  end

  def down
    raise IrreversibleMigration
  end
end
