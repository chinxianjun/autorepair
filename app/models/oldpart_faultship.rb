class OldpartFaultship < ActiveRecord::Base
  belongs_to :oldpart
  belongs_to :fault
end
