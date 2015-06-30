class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.string :manager
      t.string :category
      t.timestamps
    end
  end
end
