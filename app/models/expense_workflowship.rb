class ExpenseWorkflowship < ActiveRecord::Base
  belongs_to :expense
  belongs_to :workflow
end
