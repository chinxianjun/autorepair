class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :phone
      t.string :customer
      t.text :content
      t.string :category
      t.string :creator
      t.timestamps
    end
  end
end
