class OldpartNewpartship < ActiveRecord::Base
  belongs_to :oldpart
  belongs_to :newpart
end
