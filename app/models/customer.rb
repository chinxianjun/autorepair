class Customer < ActiveRecord::Base
  attr_accessible :fullname, :phone, :birthday, :gender, :age, :created_at, :category, :address

  has_many :customer_workflows
  has_many :workflows, :through => :customer_workflows

  has_many :faultdesc_customers
  has_many :faultdescs, :through => :faultdesc_customers

  belongs_to :company

  has_many :customer_questionships
  has_many :questions, :through => :customer_questionships

  has_many :customer_vehicleships
  has_many :vehicles, :through => :customer_vehicleships

  #has_one :customer_categoryship
  #has_one :category, :through => :customer_categoryship

  #validates :username, :allow_blank => false
  #validates :phone, :allow_blank => false

  def self.search(column)
     if column
        where('fullname LIKE ? OR phone LIKE ? OR category LIKE ? OR address LIKE ?', "%#{column}%", "%#{column}%", "%#{column}%", "%#{column}%")
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
      else
        scoped
      end
  end

end
