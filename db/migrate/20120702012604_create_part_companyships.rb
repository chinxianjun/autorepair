class CreatePartCompanyships < ActiveRecord::Migration
  def change
    create_table :part_companyships do |t|
      t.integer :part_id
      t.integer :company_id
      t.timestamps
    end
  end
end
