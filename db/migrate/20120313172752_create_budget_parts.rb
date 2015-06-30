class CreateBudgetParts < ActiveRecord::Migration
  def change
    create_table :budget_parts do |t|
      t.string   "name"
      t.string   "drawing"
      t.float    "price"
      t.string   "factory"
      t.string   "newpart_manage"
      t.string   "running_number"
      t.string   "factory_code"
      t.integer  "count"
      t.string   "category"
      t.string   "receiver"
      t.timestamps
    end
  end
end
