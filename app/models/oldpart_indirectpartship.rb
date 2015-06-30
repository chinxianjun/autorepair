class OldpartIndirectpartship < ActiveRecord::Base
  belongs_to :oldpart
  belongs_to :indirectpart
end
