class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :phone
      t.string  :address
      t.date :birthday

      t.timestamps
    end
  end
end
