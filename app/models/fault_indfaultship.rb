class FaultIndfaultship < ActiveRecord::Base
  belongs_to :fault
  belongs_to :indfault
end
