class CreatePartBuyings < ActiveRecord::Migration
  def change
    create_table :part_buyings do |t|
      t.string :part_name
      t.string :part_drawing
      t.string :part_type
      t.string :factory_name
      t.string :factory_code
      t.string :count
      t.string :part_unit_price
      t.string :part_sub_total
      t.text :description

      t.timestamps
    end
  end
end
