class CreateManagerCompanyships < ActiveRecord::Migration
  def change
    create_table :manager_companyships do |t|
      t.integer :manager_id
      t.integer :company_id
      t.timestamps
    end
  end
end
