class Indfault < ActiveRecord::Base
  has_one :indfault_indirectpartship
  has_one :indirectpart, :through => :indfault_indirectpartship

  has_one :fault_indfaultship
end
