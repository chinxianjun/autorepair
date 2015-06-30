class Vehicle < ActiveRecord::Base
  attr_accessible :model, :car_number, :engine, :engine_number, :chassis_number, :order_number,
                  :fast_type, :production_number, :first_bridge, :second_bridge, :third_bridge,
                  :driving_range, :purchase_on, :warranty_card, :user_number,
                  :transmission_number, :front_transmission_drawing, :front_transmission_code,
                  :back_transmission_drawing, :back_transmission_code, :tank_drawing, :tank_code,
                  :spring_drawing, :spring_code, :workplace, :gearbox_drawing, :gearbox_type,
                  :fullname, :phone, :idcard, :address


  has_one :vehicle_ownership
  has_one :owner, :through => :vehicle_ownership

  has_many :vehicle_workflowships
  has_many :workflows, :through => :vehicle_workflowships

  has_many  :vehicle_customerships
  has_many  :customers, :through => :vehicle_customerships

  def self.search(vehicle)
    if vehicle
      where(  'model LIKE ? OR engine LIKE ? OR engine_number LIKE ?
          OR car_number LIKE ? OR chassis_number LIKE ?
          OR fullname LIKE ? OR phone LIKE ?',
            "%#{vehicle}%", "%#{vehicle}%", "%#{vehicle}%",
            "%#{vehicle}%", "%#{vehicle}%", "%#{vehicle}%", "%#{vehicle}%"  )
    else
      scoped
    end
  end
end