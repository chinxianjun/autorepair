class ConsultingQuestionship < ActiveRecord::Base
  belongs_to :consulting
  belongs_to :question
end
