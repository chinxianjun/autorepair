class Part < ActiveRecord::Base
  attr_accessible :name, :manager, :category
  has_one :part_companyship
  has_one :company, :through => :part_companyship

  def self.search(column)
     if column
        where('name LIKE ? OR manager LIKE ? OR category LIKE ?', "%#{column}%", "%#{column}%", "%#{column}%")
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
     else
        scoped
     end
  end
end
