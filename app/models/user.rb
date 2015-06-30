class User < ActiveRecord::Base

  has_many :user_groupships
  has_many :groups, :through => :user_groupships, :uniq => true

  has_many :user_companyships
  has_many :companies, :through => :user_companyships, :uniq => true

  has_one :profile
  belongs_to :repairer

  has_one :repairman

  belongs_to :salesman

  has_many :members, :foreign_key => 'user_id', :dependent => :destroy
  has_many :memberships, :class_name => 'Member', :foreign_key => 'user_id', :include => [ :warehouse, :roles ]
  has_many :warehouses, :through => :memberships

  serialize :company_code, Array
    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :login, :phone, :address, :user_number, :username, :birthday,
                  :gender, :fullname, :default_company, :status, :token_authenticatable
  attr_accessor :login
  
  before_save :ensure_authentication_token
  
  def allowed_to?(current_user, action, company)
    # authorize if user has at least one role that has this permission
    if company.nil?
      return false
    else
      current_roles = []

      current_groups = company.groups & current_user.groups

      if current_groups
        current_groups.each do |group|
          current_roles << group.roles
        end
      end

      if !current_user.members.empty?
        current_user.members.each do |member|
          current_roles << member.roles
        end
      end

      roles = current_roles.flatten.uniq

      roles.detect { |role|  role.allowed_to?(action) }
    end
  end

  def <=>(user)
    if self.class.name == user.class.name
      self.to_s.downcase <=> user.to_s.downcase
    else
      # groups after users
      user.class.name <=> self.class.name
    end
  end

  def has_role?(role)
    self.roles.exists?(role)
  end

  def has_group?(group)
    self.groups.exists?(group)
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
  end

    # Attempt to find a user by it's email. If a record is found, send new
    # password instructions to it. If not user is found, returns a new user
    # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", {:value => login}]).first
  end
end

