class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :permissions
      t.integer :position, :default => 1
      t.integer :builtin, :default => 0, :null => false
      t.timestamps
    end
    r1 = Role.create(:name => "anonymous")
  end
end
