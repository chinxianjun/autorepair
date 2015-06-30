class Owner < ActiveRecord::Base
  attr_accessible :fullname, :phone, :idcard, :workplace, :address
  has_one :vehicle_ownership
  has_one :vehicle, :through => :vehicle_ownership

end
