class CreateNewparts < ActiveRecord::Migration
  def change
    create_table :newparts do |t|
      t.string :name
      t.string :drawing
      t.float :price
      t.string :factory
      t.string :newpart_manage

      t.timestamps
    end
  end
end
