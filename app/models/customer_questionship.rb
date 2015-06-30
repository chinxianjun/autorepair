class CustomerQuestionship < ActiveRecord::Base
  belongs_to :customer
  belongs_to :question
end
