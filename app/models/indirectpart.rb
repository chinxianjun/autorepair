class Indirectpart < ActiveRecord::Base
  has_one :oldpart_indirectpartship


  has_one :indirectpart_workflowship

  has_one :indfault_indirectpartship
  has_one :indfault, :through => :indirectpart_workflowship
end
