class Complaint < ActiveRecord::Base
  has_one :complaint_questionship
end
