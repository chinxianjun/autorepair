class CustomerWorkflow < ActiveRecord::Base
  belongs_to :customer
  belongs_to :workflow
end
