class Expense < ActiveRecord::Base
  has_one :expense_workflowship
  has_one :workflow, :through => :expense_workflowship

  has_one :expense_companyship
  has_one :expense, :through => :expense_workflowship
end
