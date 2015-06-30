class CreateOldpartIndirectpartships < ActiveRecord::Migration
  def change
    create_table :oldpart_indirectpartships do |t|
      t.integer :oldpart_id
      t.integer :indirectpart_id

      t.timestamps
    end
  end
end
