class FaultdescCustomer < ActiveRecord::Base
  belongs_to :customer
  belongs_to :faultdesc
end
