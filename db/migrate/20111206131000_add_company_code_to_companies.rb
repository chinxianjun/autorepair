class AddCompanyCodeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :company_code, :string, :uniq => true
  end
end