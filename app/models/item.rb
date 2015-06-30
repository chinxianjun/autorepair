class Item < ActiveRecord::Base
  attr_accessible :name, :code
  has_one :item_companyship
  has_one :company, :through => :item_companyship

  def self.search(column)
     if column
        where('name LIKE ? OR code LIKE ?', "%#{column}%", "%#{column}%")
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
      else
        scoped
      end
  end
end
