class NewpartFaultship < ActiveRecord::Base
  belongs_to :newpart
  belongs_to :fault
end
