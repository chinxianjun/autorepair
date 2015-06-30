class CreateIndirectpartFaultships < ActiveRecord::Migration
  def change
    create_table :indirectpart_faultships do |t|
      t.integer :indirectpart_id
      t.integer :fault_id

      t.timestamps
    end
  end
end
