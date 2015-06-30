class CreateAdminCompanyships < ActiveRecord::Migration
  def change
    create_table :admin_companyships do |t|
      t.integer :admin_id
      t.integer :company_id
      t.timestamps
    end
  end
end