class CustomerVehicleship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :customer
  belongs_to :vehicle
end
