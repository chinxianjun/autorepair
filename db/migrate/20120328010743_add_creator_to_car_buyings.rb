class AddCreatorToCarBuyings < ActiveRecord::Migration
  def change
    add_column :car_buyings, :creator, :string
    add_column :part_buyings, :creator, :string
    add_column :complaints, :creator, :string
    add_column :consultings, :creator, :string
  end
end
