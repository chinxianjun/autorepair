class FaultWorkflowship < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :fault
end
