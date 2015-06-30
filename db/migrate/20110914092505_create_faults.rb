class CreateFaults < ActiveRecord::Migration
  def change
    create_table :faults do |t|
      t.string :fault_type
      t.text :fault_analyse

      t.timestamps
    end
  end
end
