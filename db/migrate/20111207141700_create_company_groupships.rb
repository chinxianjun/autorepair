class CreateCompanyGroupships < ActiveRecord::Migration
  def change
    create_table :company_groupships do |t|
      t.integer :company_id
      t.integer :group_id
      t.timestamps
    end
  end
end