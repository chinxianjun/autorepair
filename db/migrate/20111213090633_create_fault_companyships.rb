class CreateFaultCompanyships < ActiveRecord::Migration
  def change
    create_table :fault_companyships do |t|
      t.integer :fault_id
      t.integer :company_id

      t.timestamps
    end
  end
end
