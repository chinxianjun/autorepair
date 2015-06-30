class CreateItemCompanyships < ActiveRecord::Migration
  def change
    create_table :item_companyships do |t|
      t.integer :item_id
      t.integer :company_id
      t.timestamps
    end
  end
end
