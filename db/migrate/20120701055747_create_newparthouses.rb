class CreateNewparthouses < ActiveRecord::Migration
  def change
    create_table :newparthouses do |t|
      t.string :name
      t.string :manager
      t.timestamps
    end
  end
end
