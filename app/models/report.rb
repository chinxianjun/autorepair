class Report < ActiveRecord::Base
  attr_accessible :id, :phone, :server_process_number, :server_regist_number, :infoman, :created_at

  has_one :report_workflowship
  has_one :workflow

  def self.search(column)
     if column
       where('id LIKE ? OR server_process_number LIKE ? OR server_regist_number LIKE ? OR infoman LIKE ?', "%#{column}%", "%#{column}%", "%#{column}%", "%#{column}%")
        #where(["username = :value OR phone = :value", {:value => column}])
        #find_by_sql["SELECT * FROM customers WHERE username = ? OR phone = ?", column, column]
     else
        scoped
     end
  end
end
