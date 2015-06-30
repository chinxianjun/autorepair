class CreatePermssions < ActiveRecord::Migration
  def change
    create_table :permssions do |t|
      t.text :permissions
      t.integer :role_id
      t.timestamps
    end
  end
end
