class PartBuyingQuestionship < ActiveRecord::Base
  belongs_to :part_buying
  belongs_to :question
end
