class RoleMembership < ActiveRecord::Base
  belongs_to :role
  belongs_to :member

  after_destroy :remove_member_if_empty


  validates_presence_of :role
  validate :validate_role_member

  def validate_role_member
    errors.add :role_id, :invalid if role && !role.member?
  end

  def inherited?
    !inherited_from.nil?
  end

  private

  def remove_member_if_empty
    if member.roles.empty?
      member.destroy
    end
  end
end
