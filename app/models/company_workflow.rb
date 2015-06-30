class CompanyWorkflow < ActiveRecord::Base
  belongs_to :company
  belongs_to :workflow
end
