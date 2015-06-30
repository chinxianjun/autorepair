require 'jartai'
require 'jartai/access_control'

class Role < ActiveRecord::Base
  include Jartai::AccessControl

  before_destroy :check_deletable

  has_many :role_groupships
  has_many :groups, :through => :role_groupships, :uniq => true

  has_many :role_memberships, :dependent => :destroy
  has_many :members, :through => :role_memberships, :uniq => true

  # Built-in roles
  BUILTIN_NON_MEMBER = 1
  BUILTIN_ANONYMOUS  = 2

  scope :builtin, lambda { |*args|
    compare = (args.first == true ? 'not' : '')
    where("#{compare} builtin = 0")
  }

  acts_as_list

  serialize :permissions, Array
  attr_protected :builtin

  validates_presence_of :name
  validates_uniqueness_of :name

  def permissions
    read_attribute(:permissions) || []
  end

  def permissions=(perms)
    perms = perms.collect {|p| p.to_sym unless p.blank? }.compact.uniq if perms
    write_attribute(:permissions, perms)
  end

  def add_permission!(*perms)
    self.permissions = [] unless permissions.is_a?(Array)

    permissions_will_change!
    perms.each do |p|
      p = p.to_sym
      permissions << p unless permissions.include?(p)
    end
    save!
  end

  def remove_permission!(*perms)
    return unless permissions.is_a?(Array)
    permissions_will_change!
    perms.each { |p| permissions.delete(p.to_sym) }
    save!
  end

  # Returns true if the role has the given permission
  def has_permission?(perm)
    !permissions.nil? && permissions.include?(perm.to_sym)
  end

  def <=>(role)
    role ? position <=> role.position : -1
  end

  def to_s
    name
  end

  # Return true if the role is a builtin role
  def builtin?
    self.builtin != 0
  end

  # Return true if the role is a project member role
  def member?
    !self.builtin?
  end

  # Return true if role is allowed to do the specified action
  # action can be:
  # * a parameter-like Hash (eg. :controller => 'projects', :action => 'edit')
  # * a permission Symbol (eg. :edit_project)
  def allowed_to?(action)
    if action.is_a? Hash
      allowed_actions.include? "#{action[:controller]}/#{action[:action]}"
    else
      allowed_permissions.include? action
    end
  end

  # Return all the permissions that can be given to the role
  def setable_permissions
    setable_permissions = Jartai::AccessControl.permissions - Jartai::AccessControl.public_permissions
    setable_permissions -= Jartai::AccessControl.members_only_permissions if self.builtin == BUILTIN_NON_MEMBER
    setable_permissions -= Jartai::AccessControl.loggedin_only_permissions if self.builtin == BUILTIN_ANONYMOUS
    setable_permissions
  end

  # Find all the roles that can be given to a project member
  def self.find_all_givable
    find(:all, :conditions => {:builtin => 0}, :order => 'position')
  end

  # Return the builtin 'non member' role.  If the role doesn't exist,
  # it will be created on the fly.
  def self.non_member
    find_or_create_system_role(BUILTIN_NON_MEMBER, 'Non member')
  end

  # Return the builtin 'anonymous' role.  If the role doesn't exist,
  # it will be created on the fly.
  def self.anonymous
    find_or_create_system_role(BUILTIN_ANONYMOUS, 'Anonymous')
  end


private
  def allowed_permissions
    @allowed_permissions ||= permissions + Jartai::AccessControl.public_permissions.collect {|p| p.name}
  end

  def allowed_actions
    @actions_allowed ||= allowed_permissions.inject([]) { |actions, permission| actions += Jartai::AccessControl.allowed_actions(permission) }.flatten
    #puts "###### allowed_permissions begin ######"
    #puts allowed_permissions
    #puts "###### allowed_permissions end   ######"
  end

  def check_deletable
    # how to confirm role has not any users/groups
    raise "Can't delete role" if members.any?
    raise "Can't delete builtin role" if builtin?
  end
end
