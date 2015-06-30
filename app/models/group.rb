class Group < ActiveRecord::Base

  has_many :user_groupships
  has_many :users, :through => :user_groupships, :uniq => true

  has_many :role_groupships
  has_many :roles, :through => :role_groupships, :uniq => true

  has_many :company_groupships
  has_many :companies, :through => :company_groupships, :uniq => true

  has_many :members, :foreign_key => 'group_id', :dependent => :destroy
  has_many :memberships, :class_name => 'Member', :foreign_key => 'group_id', :include => [ :warehouse, :roles ]
  has_many :warehouses, :through => :memberships

  def has_group?(group)
    self.groups.exists?(group)
  end
end
