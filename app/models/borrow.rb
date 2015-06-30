class Borrow < ActiveRecord::Base
  has_one :workflow_borrowship
  has_one :workflow, :through => :workflow_borrowship
end
