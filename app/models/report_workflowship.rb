class ReportWorkflowship < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :report
end
