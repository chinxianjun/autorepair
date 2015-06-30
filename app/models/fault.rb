class Fault < ActiveRecord::Base
  #attr_accessor :fault_analyse, :measure, :fault_desc

  has_one :fault_workflowship

  has_one :oldpart_faultship
  has_one :oldpart, :through => :oldpart_faultship

  has_one :newpart_faultship
  has_one :newpart, :through => :newpart_faultship

  has_many :fault_indfaultships
  has_many :indfaults, :through => :fault_indfaultships

  def self.search(faults)
    if faults
      where('measure LIKE ? OR fault_analyse LIKE ? OR :fault_desc LIKE ?',
            "%#{faults}%", "%#{faults}%", "%#{faults}%")
    else
      scoped
    end
  end
end
