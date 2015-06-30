class Admin < ActiveRecord::Base
  #devise :database_authenticatable, :trackable, :timeoutable, :lockable, :registerable
  #attr_accessible :email, :password, :password_confirmation, :username, :login,
  #                :gender, :fullname, :phone
  #attr_accessor :login
  #has_many :admin_companyships
  #has_many :companies, :through => :admin_companyships, :uniq => true
  #
  #has_one :admin_profileship
  #has_one :profile, :through => :admin_profileship
  #
  ## Allow admins to Sign In using their username or email address
  #def self.find_for_authentication(conditions)
  #  login = conditions.delete(:login)
  #  where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  #end
end