class AddDefaultCompanyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_company, :string
  end
end
