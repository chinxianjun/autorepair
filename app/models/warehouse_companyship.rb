class WarehouseCompanyship < ActiveRecord::Base
  belongs_to :warehouse
  belongs_to :company
end
