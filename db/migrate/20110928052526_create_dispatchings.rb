class CreateDispatchings < ActiveRecord::Migration
  def change
    create_table :dispatchings do |t|
      t.string :repairer
      t.string :dispatcher
      t.string :reception

      t.timestamps
    end
  end
end
