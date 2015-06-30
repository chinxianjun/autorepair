class Question < ActiveRecord::Base
  has_one :customer_questionship
  has_one :customer, :through => :customer_questionship

  has_one :faultdesc_questionship
  has_one :faultdesc, :through => :faultdesc_questionship

  has_many :car_buying_questionships
  has_many :car_buyings, :through => :car_buying_questionships


  has_many :part_buying_questionships
  has_many :part_buyings, :through => :part_buying_questionships

  has_many :complaint_questionships
  has_many :complaints, :through => :complaint_questionships

  has_many :consulting_questionships
  has_many :consultings, :through => :consulting_questionships
end
