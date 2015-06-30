class ComplaintQuestionship < ActiveRecord::Base
  belongs_to :complaint
  belongs_to :question
end
