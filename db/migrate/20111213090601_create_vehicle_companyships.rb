class CreateVehicleCompanyships < ActiveRecord::Migration
  def change
    create_table :vehicle_companyships do |t|
      t.integer :vehicle_id
      t.integer :company_id

      t.timestamps
    end
  end
end
