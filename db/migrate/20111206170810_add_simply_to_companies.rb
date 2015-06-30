class AddSimplyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :simply, :string, :uniq => true
  end
end
