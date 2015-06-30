class OldpartWorkflowship < ActiveRecord::Base
  belongs_to :oldpart
  belongs_to :workflow
end
