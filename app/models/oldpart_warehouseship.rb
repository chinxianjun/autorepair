class OldpartWarehouseship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :oldpart
  belongs_to :warehouse

end
