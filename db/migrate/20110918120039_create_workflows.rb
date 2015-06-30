class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
