class CreateNewpartCompanyships < ActiveRecord::Migration
  def change
    create_table :newpart_companyships do |t|
      t.integer :newpart_id
      t.integer :company_id

      t.timestamps
    end
  end
end
