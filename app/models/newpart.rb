class Newpart < ActiveRecord::Base
  #attr_accessor :category, :name, :drawing

  has_many :oldpart_newpartships
  has_many :oldparts, :through => :oldpart_newpartships

  has_one :newpart_faultship
  has_one :fault, :through => :newpart_faultship

  has_one :newpart_workflowship


  before_create :init_uuid

  def init_uuid
    self.uuid = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, "www.ht4s.com").to_s
  end

  def self.search(newparts)
    if newparts
      where('category LIKE ? OR name LIKE ? OR drawing LIKE ?',
            "%#{newparts}%", "%#{newparts}%", "%#{newparts}%")
    else
      scoped
    end
  end
end
