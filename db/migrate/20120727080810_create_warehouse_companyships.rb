class CreateWarehouseCompanyships < ActiveRecord::Migration
  def change
    create_table :warehouse_companyships do |t|
      t.integer :warehouse_id
      t.integer :company_id
      t.timestamps
    end
  end
end
