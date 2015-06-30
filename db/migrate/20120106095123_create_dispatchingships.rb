class CreateDispatchingships < ActiveRecord::Migration
  def change
    create_table :dispatchingships do |t|
      t.integer :dispatching_id
      t.integer :sub_dispatching_id

      t.timestamps
    end
  end
end