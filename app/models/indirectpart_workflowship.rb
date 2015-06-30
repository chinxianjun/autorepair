class IndirectpartWorkflowship < ActiveRecord::Base
  belongs_to :indirect_to
  belongs_to :workflow
end
