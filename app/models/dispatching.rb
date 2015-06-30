class Dispatching < ActiveRecord::Base
  has_one :dispatching_workflow
  has_one :workflow, :through => :dispatching_workflow

  has_many :dispatching_budgetships
  has_many :budgets, :through => :dispatching_budgetships
end
