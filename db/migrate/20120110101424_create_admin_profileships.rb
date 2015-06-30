class CreateAdminProfileships < ActiveRecord::Migration
  def change
    create_table :admin_profileships do |t|
      t.integer :admin_id
      t.integer :profile_id
      t.timestamps
    end
  end
end
