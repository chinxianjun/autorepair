class FaultdecsQuestionship < ActiveRecord::Base
  belongs_to :faultdesc
  belongs_to :question
end
