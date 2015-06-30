class CarBuyingQuestionship < ActiveRecord::Base
  belongs_to :car_buying
  belongs_to :question
end
