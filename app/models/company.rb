class Company < ActiveRecord::Base
  has_many :manager_companyships
  has_many :managers, :through => :manager_companyships, :uniq => true

  has_many :company_groupships
  has_many :groups, :through => :company_groupships, :uniq => true

  has_many :user_companyships
  has_many :users, :through => :user_companyships, :uniq => true

  has_one :repairer

  has_many :company_workflows
  has_many :workflows, :through => :company_workflows

  has_one :expense_companyship
  has_one :expense, :through => :expense_companyship

  has_one :salesman

  has_many :part_companyships
  has_many :parts, :through => :part_companyships

  has_many :item_companyships
  has_many :items, :through => :item_companyships

  has_many :warehouse_companyships
  has_many :warehouses, :through => :warehouse_companyships
end