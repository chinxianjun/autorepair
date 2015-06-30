class UserWarehouseship < ActiveRecord::Base
  belongs_to :user
  belongs_to :warehouse
end
