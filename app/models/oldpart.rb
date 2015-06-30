require "uuidtools"
class Oldpart < ActiveRecord::Base

  has_many :oldpart_indirectpartships
  has_many :indirectparts, :through => :oldpart_indirectpartships

  has_many :oldpart_newpartships
  has_many :newparts, :through => :oldpart_newpartships

  has_one :oldpart_faultship
  has_one :fault, :through => :oldpart_faultship

  has_one :oldpart_workflowship

  has_one :oldpart_warehouseship
  has_one :warehouse, :through => :oldpart_warehouseship

  #set_primary_key :uuid;

  before_create :init_uuid

  def init_uuid
    self.uuid = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, "www.ht4s.com")
  end

  def self.search(column)
     if column
        where('name LIKE ? OR drawing LIKE ? OR factory_code LIKE ? OR factory LIKE ?', "%#{column}%", "%#{column}%", "%#{column}%", "%#{column}%")
      else
        scoped
      end
  end
end
