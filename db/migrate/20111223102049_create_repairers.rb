class CreateRepairers < ActiveRecord::Migration
  def change
    create_table :repairers do |t|
      t.integer :company_id
      t.string :name
      t.timestamps
    end
  end
end
