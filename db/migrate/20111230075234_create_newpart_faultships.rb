class CreateNewpartFaultships < ActiveRecord::Migration
  def change
    create_table :newpart_faultships do |t|
      t.integer :newpart_id
      t.integer :fault_id

      t.timestamps
    end
  end
end
