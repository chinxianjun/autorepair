class IndirectpartFaultship < ActiveRecord::Base
  belongs_to :indirectpart
  belongs_to :fault
end
