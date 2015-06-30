class DispatchingBudgetship < ActiveRecord::Base
  belongs_to :dispatching
  belongs_to :budget
end
