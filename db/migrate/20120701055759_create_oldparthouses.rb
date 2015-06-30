class CreateOldparthouses < ActiveRecord::Migration
  def change
    create_table :oldparthouses do |t|
      t.string :name
      t.string :manager
      t.timestamps
    end
  end
end
