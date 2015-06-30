class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :name
      t.text :description
      t.text :users
      t.text :roles
      t.timestamps
    end
    g1 = Group.create(:name => "anonymous")
  end
end
