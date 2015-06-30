class CreateIndfaultIndirectpartships < ActiveRecord::Migration
  def change
    create_table :indfault_indirectpartships do |t|
      t.integer :indfault_id
      t.integer :indirectpart_id
      t.timestamps
    end
  end
end
