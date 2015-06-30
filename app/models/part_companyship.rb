class PartCompanyship < ActiveRecord::Base
  belongs_to :part
  belongs_to :company
end
