class Status < ActiveRecord::Base
  attr_accessible :name

  def self.search(column)
    if column
      where('name LIKE ?', "%#{column}%")
    else
      scoped
    end
  end

end
