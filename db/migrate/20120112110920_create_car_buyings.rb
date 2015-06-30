class CreateCarBuyings < ActiveRecord::Migration
  def change
    create_table :car_buyings do |t|
      t.string :factory
      t.string :kind
      t.string :price_range
      t.text :description
      t.string :referral
      t.string :manager
      t.string :salesman
      t.string :status
      t.text :reason

      t.timestamps
    end
  end
end
