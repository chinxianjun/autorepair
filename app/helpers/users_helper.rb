module UsersHelper
  def get_serialNumber(factory)
    number = 100001

    unless User.last.nil?
      number += User.last.id
    end

     serial_number = factory + number.to_s
  end

end
