class Budget < ActiveRecord::Base
  has_one :dispatching_budgetship
  has_one :dispatching, :through => :dispatching_budgetship
end
