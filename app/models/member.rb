class Member < ActiveRecord::Base
  has_many :role_memberships, :dependent => :destroy
  has_many :roles, :through => :role_memberships

  belongs_to :user, :foreign_key => 'user_id'
  belongs_to :group, :foreign_key => 'group_id'

  belongs_to :warehouse

  #validate :validate_role
  after_save :validate_role_member


  def role
  end

  def role=
  end

  def name
    self.user.fullname
  end

  alias :base_role_ids= :role_ids=
  def role_ids=(arg)
    ids = (arg || []).collect(&:to_i) - [0]
    # Keep inherited roles
    ids += role_memberships.select {|mr| !mr.inherited_from.nil?}.collect(&:role_id)

    new_role_ids = ids - role_ids
    # Add new roles
    new_role_ids.each {|id| role_memberships << RoleMembership.new(:role_id => id) }
    # Remove roles (Rails' #role_ids= will not trigger MemberRole#on_destroy)
    member_roles_to_destroy = role_memberships.select {|mr| !ids.include?(mr.role_id)}
    if member_roles_to_destroy.any?
      member_roles_to_destroy.each(&:destroy)
    end
  end

  protected

  def validate_role
    errors.add_on_empty :role if role_memberships.empty? && roles.empty?
  end

  def validate_role_member
    if self.roles.empty?
      self.destroy
    end
  end
end