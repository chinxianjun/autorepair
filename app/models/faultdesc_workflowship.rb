class FaultdescWorkflowship < ActiveRecord::Base
  belongs_to :faultdesc
  belongs_to :workflow
end
