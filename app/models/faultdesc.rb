class Faultdesc < ActiveRecord::Base
  #has_one :faultdesc_workflowship
  #has_one :workflow, :through => :faultdesc_workflowship
  #
  has_one :faultdesc_questionship
  has_one :question, :through => :faultdesc_questionship
end
