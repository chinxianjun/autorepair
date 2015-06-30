class CreateOldpartFaultships < ActiveRecord::Migration
  def change
    create_table :oldpart_faultships do |t|
      t.integer :oldpart_id
      t.integer :fault_id

      t.timestamps
    end
  end
end
