class Dispatchingship < ActiveRecord::Base
  belongs_to :dispatching
  belongs_to :sub_dispatching
end