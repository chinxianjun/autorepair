class CreateRepairmen < ActiveRecord::Migration
  def change
    create_table :repairmen do |t|
      t.integer :workflow_id
      t.integer :user_id
      t.timestamps
    end
  end
end
