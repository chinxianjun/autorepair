class CreateIndfaults < ActiveRecord::Migration
  def change
    create_table :indfaults do |t|
      t.string :measure
      t.text :fault_analyse
      t.string :creator
      t.timestamps
    end
  end
end
