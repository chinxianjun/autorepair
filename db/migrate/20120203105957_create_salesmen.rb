class CreateSalesmen < ActiveRecord::Migration
  def change
    create_table :salesmen do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :name
      t.string :status
      t.timestamps
    end
  end
end
