class CreateFaultIndfaultships < ActiveRecord::Migration
  def change
    create_table :fault_indfaultships do |t|
      t.integer :fault_id
      t.integer :indfault_id
      t.timestamps
    end
  end
end
