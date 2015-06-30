class Workflow < ActiveRecord::Base
  has_one :customer_workflow
  has_one :company_workflow

  has_one :customer_workflow
  has_one :workflow, :through => :customer_workflow

  has_many :fault_workflowships
  has_many :faults, :through => :fault_workflowships

  has_one :dispatching_workflow
  has_one :dispatching, :through => :dispatching_workflow

  has_one :faultdesc_workflowship
  has_one :faultdesc, :through => :faultdesc_workflowship

  has_one :vehicle_workflowship

  has_many :oldpart_workflowships
  has_many :oldparts, :through => :oldpart_workflowships

  has_many :indirectpart_workflowships
  has_many :indirectparts, :through => :indirectpart_workflowships

  has_many :newpart_workflowships
  has_many :newparts, :through => :newpart_workflowships

  has_one :report_workflowship
  has_one :report, :through => :report_workflowship

  has_many :repairmen
  has_many :users, :through => :repairmen

  has_one :expense_workflowship
  has_one :expense, :through => :expense_workflowship

  has_many :workflow_borrowships
  has_many :borrows, :through => :workflow_borrowships

end
