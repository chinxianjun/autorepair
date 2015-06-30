class ExpenseCompanyship < ActiveRecord::Base
  belongs_to :expense
  belongs_to :company
end
