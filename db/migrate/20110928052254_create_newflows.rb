class CreateNewflows < ActiveRecord::Migration
  def change
    create_table :newflows do |t|
      t.string :status

      t.timestamps
    end
  end
end
