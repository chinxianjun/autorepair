class WorkflowBorrowship < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :borrow
end
