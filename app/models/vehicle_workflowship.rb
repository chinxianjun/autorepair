class VehicleWorkflowship < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :vehicle
end
