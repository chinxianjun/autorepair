class DispatchingWorkflow < ActiveRecord::Base
  belongs_to :dispatching
  belongs_to :workflow
end
