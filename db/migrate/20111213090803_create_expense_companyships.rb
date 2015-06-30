class CreateExpenseCompanyships < ActiveRecord::Migration
  def change
    create_table :expense_companyships do |t|
      t.integer :expense_id
      t.integer :company_id

      t.timestamps
    end
  end
end
