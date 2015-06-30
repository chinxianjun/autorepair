class Category < ActiveRecord::Base
  #has_one :customer_categoryship
  #has_one :customer, :through => :customer_categoryship

  def self.search(search)
     if search
        where('category LIKE ?', "%#{search}%")
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
     else
        scoped
     end
  end
end
