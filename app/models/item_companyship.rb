class ItemCompanyship < ActiveRecord::Base
  belongs_to :item
  belongs_to :company
end
