class Warehouse < ActiveRecord::Base
  has_one :warehouse_companyship
  has_one :company, :through => :warehouse_companyship

  has_many :oldpart_warehouseships
  has_many :oldparts, :through => :oldpart_warehouseships


  has_many :users, :through => :members
  has_many :groups, :through => :members
  has_many :memberships, :class_name => 'Member'

  has_many :members, :include => [:user, :group, :roles]

  acts_as_nested_set
  attr_accessible :name, :category, :manager, :parent_id, :identifier

  validates_uniqueness_of :identifier
  serialize :neighbor_ids, Array
  serialize :follows, Array

  def self.search(column, wid)
     if column
        Oldpart.where("name LIKE ? OR category LIKE ? OR manager LIKE ? OR parent_id LIKE ?",
                      "%#{column}%", "%#{column}%", "%#{column}%", "%#{column}%").joins(:warehouse).where('warehouses.id' => wid)
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
     else
        scoped
     end
  end

  def archived
  end

  def archived?
    archived.blank?
  end

  # Returns an array of warehouses the warehouse can be moved to
  # by the current user
  def allowed_parents
    return @allowed_parents if @allowed_parents
    @allowed_parents = Warehouse.find(:all, :conditions => Warehouse.allowed_to_condition(User.current, :add_subprojects))
    @allowed_parents = @allowed_parents - self_and_descendants
    if Manager.current.allowed_to?(:add_warehouse, nil, :global => true) || (!new_record? && parent.nil?)
      @allowed_parents << nil
    end
    unless parent.nil? || @allowed_parents.empty? || @allowed_parents.include?(parent)
      @allowed_parents << parent
    end
    @allowed_parents
  end

  # Sets the parent of the project with authorization check
  def set_allowed_parent!(p)
    unless p.nil? || p.is_a?(Warehouse)
      if p.to_s.blank?
        p = nil
      else
        p = Warehouse.find_by_id(p)
        return false unless p
      end
    end
    if p.nil?
      if !new_record? && allowed_parents.empty?
        return false
      end
    elsif !allowed_parents.include?(p)
      return false
    end
    set_parent!(p)
  end

  # Sets the parent of the warehouse
  # Argument can be either a Warehouse, a String, a Fixnum or nil
  def set_parent!(p)
    unless p.nil? || p.is_a?(Warehouse)
      if p.to_s.blank?
        p = nil
      else
        p = Warehouse.find_by_id(p)
        return false unless p
      end
    end
    if p == parent && !p.nil?
      # Nothing to do
      true
    elsif p.nil? || (p.active? && move_possible?(p))
      # Insert the project so that target's children or root projects stay alphabetically sorted
      sibs = (p.nil? ? self.class.roots : p.children)
      to_be_inserted_before = sibs.detect {|c| c.name.to_s.downcase > name.to_s.downcase }
      if to_be_inserted_before
        move_to_left_of(to_be_inserted_before)
      elsif p.nil?
        if sibs.empty?
          # move_to_root adds the project in first (ie. left) position
          move_to_root
        else
          move_to_right_of(sibs.last) unless self == sibs.last
        end
      else
        # move_to_child_of adds the project in last (ie.right) position
        move_to_child_of(p)
      end
      #Issue.update_versions_from_hierarchy_change(self)
      true
    else
      # Can not move to the given target
      false
    end
  end

  def warehouse
    self
  end

  def <=>(warehouse)
    name.downcase <=> warehouse.name.downcase
  end

  def to_s
    name
  end

  def css_classes
    s = 'warehouse'
    s << ' root' if root?
    s << ' child' if child?
    s << (leaf? ? ' leaf' : ' parent')
    #unless active?
    #  if archived?
    #    s << ' archived'
    #  else
    #    s << ' closed'
    #  end
    #end
    s
  end

  def hierarchy
    parents = warehouse.self_and_ancestors || []
    descendants = warehouse.descendants || []
    warehouse_hierarchy = parents | descendants # Set union
  end


  def self.next_identifier
    w = Warehouse.all.order('created_on DESC').first
    w.nil? ? nil : w.identifier.to_s.succ
  end

  def allows_to?(action)
    #if company.nil?
    #  return false
    #else
    #  current_roles = []
    #  if !warehouse.members.blank?
    #    warehouse.members.each do |member|
    #      if !member.role_ids.blank?
    #        current_roles << member.roles
    #      end
    #    end
    #  end
    #  puts "#########judge is allowed?#########"
    #  roles = current_roles.flatten.uniq
    #  roles.detect { |role|  role.allowed_to?(action) }
    #end

    if action.is_a? Hash
      #puts ">>>>>>>>>>>>>Warehouse model allows_to? is array"
      allowed_actions.include? "#{action[:controller]}/#{action[:action]}"
    else
      #puts ">>>>>>>>>>>>>Warehouse model allows_to? is not array"
      allowed_permissions.include? action
    end
  end

  def neighbors
    read_attribute(:neighbors) || []
  end

  def permissions
    read_attribute(:permissions) || []
  end

  def allowed_actions
    @actions_allowed ||= allowed_permissions.inject([]) { |actions, permission| actions += Jartai::AccessControl.allowed_actions(permission) }.flatten
  end

  def allowed_permissions
    @allowed_permissions ||= permissions
  end

  def short_description(length = 255)
    description.gsub(/^(.{#{length}}[^\n\r]*).*$/m, '\1...').strip if description
  end

  def self.warehouse_tree(warehouses, &block)
    ancestors = []
    warehouses.sort_by(&:lft).each do |warehouse|
      while (ancestors.any? && !warehouse.is_descendant_of?(ancestors.last))
        ancestors.pop
      end
      yield warehouse, ancestors.size
      ancestors << warehouse
    end
  end

  def follows
    read_attribute(:follows) || []
  end

  def follows=(flows)
    flows = flows.collect {|f| f.to_sym unless f.blank? }.compact.uniq if flows
    write_attribute(:follows, flows)
  end

  def add_follow!(*flows)
    self.follows = [] unless follows.is_a?(Array)

    follows_will_change!
    flows.each do |f|
      f = f.to_sym
      follows << f unless follows.include?(f)
    end
    save!
  end

  def remove_follow!(*flows)
    return unless follows.is_a?(Array)
    follows_will_change!
    flows.each { |f| follows.delete(f.to_sym) }
    save!
  end

  def has_follow?(flow)
    !follows.nil? && follows.include?(flow.to_sym)
  end
end
