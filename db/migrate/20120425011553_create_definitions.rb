class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|

      t.timestamps
    end
  end
end
