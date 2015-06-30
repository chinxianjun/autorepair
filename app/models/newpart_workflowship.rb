class NewpartWorkflowship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :newpart
  belongs_to :workflow
end
