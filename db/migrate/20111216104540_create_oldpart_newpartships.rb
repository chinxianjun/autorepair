class CreateOldpartNewpartships < ActiveRecord::Migration
  def change
    create_table :oldpart_newpartships do |t|
      t.integer :oldpart_id
      t.integer :newpart_id
      t.timestamps
    end
  end
end
