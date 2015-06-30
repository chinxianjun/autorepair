class VehicleOwnership < ActiveRecord::Base
  belongs_to :owner
  belongs_to :vehicle
end
