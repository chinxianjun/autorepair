require 'jartai/access_control'

# Permissions
Jartai::AccessControl.map do |map|
  map.feature_module :customers do |map|
      map.permission :view_customer, {:customers => [:show, :index, :business, :level]}, :require => :loggedin
      map.permission :search_customer, {:customers => [:search, :level]}, :require => :loggedin
      map.permission :add_customer, {:customers => [:new, :create, :category, :level]}, :require => :loggedin
      map.permission :edit_customer, {:customers => [:edit, :update, :level]}, :require => :loggedin
      map.permission :destroy_customer, {:customers => [:destroy, :level]}, :require => :loggedin
  end

  map.feature_module :dispatchings do |map|
      map.permission :view_dispatching, {:dispatchings => [:show, :index]}, :require => :loggedin
      map.permission :search_dispatching, {:dispatchings => [:search]}, :require => :loggedin
      map.permission :add_dispatching, {:dispatchings => [:new, :create, :budget]}, :require => :loggedin
      map.permission :edit_dispatching, {:dispatchings => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_dispatching, {:dispatchings => [:destroy, :budget_del]}, :require => :loggedin
      map.permission :flow_dispatch, {:dispatchings => [:dispatch_flow]}, :require => :loggedin
  end

  map.feature_module :vehicles do |map|
      map.permission :view_vehicle, {:vehicles => [:show, :index]}, :require => :loggedin
      map.permission :search_vehicle, {:vehicles => [:search]}, :require => :loggedin
      map.permission :add_vehicle, {:vehicles => [:new, :create]}, :require => :loggedin
      map.permission :edit_vehicle, {:vehicles => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_vehicle, {:vehicles => [:destroy]}, :require => :loggedin
      map.permission :flow_vehicle, {:vehicles => [:vehicle_flow]}, :require => :loggedin
  end
  map.feature_module :owners do |map|
      map.permission :view_owner, {:vehicles => [:owner_show, :owner_index]}, :require => :loggedin
      map.permission :search_owner, {:vehicles => [:search]}, :require => :loggedin
      map.permission :add_owner, {:vehicles => [:owner_new, :owner_create]}, :require => :loggedin
      map.permission :edit_owner, {:vehicles => [:owner_edit, :owner_update]}, :require => :loggedin
      map.permission :destroy_owner, {:vehicles => [:owner_destroy]}, :require => :loggedin
  end

  map.feature_module :faults do |map|
      map.permission :view_fault, {:faults => [:show, :index]}, :require => :loggedin
      map.permission :search_fault, {:faults => [:search]}, :require => :loggedin
      map.permission :add_fault, {:faults => [:new, :create, :ind_fault_create, :finished, :oldpart_search]}, :require => :loggedin
      map.permission :edit_fault, {:faults => [:edit, :update, :ind_fault_edit, :ind_fault_update, :finished]}, :require => :loggedin
      map.permission :destroy_fault, {:faults => [:destroy, :ind_fault_destroy]}, :require => :loggedin
      map.permission :flow_fault, {:faults => [:fault_flow]}, :require => :loggedin
  end

  map.feature_module :warehouses do |map|
      map.permission :view_warehouse, {:warehouses => [:show, :index]}, :require => :loggedin
      map.permission :search_warehouse, {:warehouses => [:index]}, :require => :loggedin
      map.permission :add_warehouse, {:warehouses => [:new, :create]}, :require => :loggedin
      map.permission :edit_warehouse, {:warehouses => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_warehouse, {:warehouses => [:destroy]}, :require => :loggedin
  end

  map.feature_module :oldparts do |map|
      map.permission :view_oldpart, {:oldparts => [:show, :index]}, :require => :loggedin
      map.permission :search_oldpart, {:oldparts => [:search]}, :require => :loggedin
      map.permission :add_oldpart, {:oldparts => [:new, :inde_new, :create, :ind_create, :oldpart_search, :oldpart_out]}, :require => :loggedin
      map.permission :edit_oldpart, {:oldparts => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_oldpart, {:oldparts => [:destroy]}, :require => :loggedin
      map.permission :flow_oldpart, {:oldparts => [:oldpart_flow]}, :require => :loggedin
  end

  map.feature_module :newparts do |map|
      map.permission :view_newpart, {:newparts => [:show, :index]}, :require => :loggedin
      map.permission :search_newpart, {:newparts => [:search]}, :require => :loggedin
      map.permission :add_newpart, {:newparts => [:new, :create, :newpart_search]}, :require => :loggedin
      map.permission :edit_newpart, {:newparts => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_newpart, {:newparts => [:destroy]}, :require => :loggedin
      map.permission :flow_newpart, {:newparts => [:newpart_flow]}, :require => :loggedin
      map.permission :receive_newpart, {:newparts => [:receive, :receive_finish]}, :require => :loggedin
  end

  map.feature_module :reports do |map|
      map.permission :view_report, {:reports => [:show, :index]}, :require => :loggedin
      map.permission :search_report, {:reports => [:search]}, :require => :loggedin
      map.permission :add_report, {:reports => [:new, :create, :getflow]}, :require => :loggedin
      map.permission :edit_report, {:reports => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_report, {:reports => [:destroy]}, :require => :loggedin
      map.permission :flow_report, {:reports => [:report_flow]}, :require => :loggedin
  end

  map.feature_module :expenses  do |map|
      map.permission :view_expense, {:expenses => [:show, :index]}, :require => :loggedin
      map.permission :search_expense, {:expenses => [:search]}, :require => :loggedin
      map.permission :add_expense, {:expenses => [:new, :create]}, :require => :loggedin
      map.permission :edit_expense, {:expenses => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_expense, {:expenses => [:destroy]}, :require => :loggedin
      map.permission :flow_expense, {:expenses => [:expense_flow]}, :require => :loggedin
  end

  map.feature_module :workflows do |map|
      map.permission :view_workflow, {:workflows => [:show, :index]}, :require => :loggedin
      map.permission :search_workflow, {:workflows => [:index]}, :require => :loggedin
      map.permission :add_workflow, {:workflows => [:new, :create]}, :require => :loggedin
      map.permission :edit_workflow, {:workflows => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_workflow, {:workflows => [:destroy]}, :require => :loggedin
      map.permission :flow_workflow, {:workflows => [:workflow_flow]}, :require => :loggedin
      map.permission :home_workflow, {:home => [:login]}, :require => :loggedin
  end

  map.feature_module :car_buyings do |map|
      map.permission :view_car_buying, {:car_buyings => [:show, :index]}, :require => :loggedin
      map.permission :search_car_buying, {:car_buyings => [:index]}, :require => :loggedin
      map.permission :add_car_buying, {:car_buyings => [:new, :create, :add_salesman]}, :require => :loggedin
      map.permission :edit_car_buying, {:car_buyings => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_car_buying, {:car_buyings => [:destroy]}, :require => :loggedin
  end

  map.feature_module :complaints do |map|
      map.permission :view_complaint, {:complaints => [:show, :index]}, :require => :loggedin
      map.permission :search_complaint, {:complaints => [:index]}, :require => :loggedin
      map.permission :add_complaint, {:complaints => [:new, :create]}, :require => :loggedin
      map.permission :edit_complaint, {:complaints => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_complaint, {:complaints => [:destroy]}, :require => :loggedin
  end

  map.feature_module :part_buyings do |map|
      map.permission :view_part_buying, {:part_buyings => [:show, :index]}, :require => :loggedin
      map.permission :search_part_buying, {:part_buyings => [:index]}, :require => :loggedin
      map.permission :add_part_buying, {:part_buyings => [:new, :create, :add_salesman]}, :require => :loggedin
      map.permission :edit_part_buying, {:part_buyings => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_part_buying, {:part_buyings => [:destroy]}, :require => :loggedin
  end

  map.feature_module :consultings do |map|
      map.permission :view_consulting, {:consultings => [:show, :index]}, :require => :loggedin
      map.permission :search_consulting, {:consultings => [:index]}, :require => :loggedin
      map.permission :add_consulting, {:consultings => [:new, :create]}, :require => :loggedin
      map.permission :edit_consulting, {:consultings => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_consulting, {:consultings => [:destroy]}, :require => :loggedin
  end

  map.feature_module :questions do |map|
      map.permission :view_question, {:questions => [:show, :index, :repair, :buy_car, :buy_part, :consulting, :complaint, :managers]}, :require => :loggedin
      map.permission :search_question, {:questions => [:index]}, :require => :loggedin
      map.permission :add_question, {:questions => [:new, :create, :search_vehicle, :repair_new, :buy_car_new, :buy_part_new, :consulting_new, :complaint_new]}, :require => :loggedin
      map.permission :edit_question, {:questions => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_question, {:questions => [:destroy]}, :require => :loggedin
  end

  map.feature_module :messages do |map|
      map.permission :view_message, {:messages => [:history, :show, :index, :multi_messages, :company_message, :customer_message, :account, :multi_send_msg, :send_msg]}, :require => :loggedin
      map.permission :search_message, {:messages => [:index]}, :require => :loggedin
      map.permission :add_message, {:messages => [:new, :create]}, :require => :loggedin
      map.permission :edit_message, {:messages => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_message, {:messages => [:destroy]}, :require => :loggedin
  end

  map.feature_module :items do |map|
      map.permission :view_item, {:items => [:show, :index]}, :require => :loggedin
      map.permission :search_item, {:items => [:index, :search_items]}, :require => :loggedin
      map.permission :add_item, {:items => [:new, :create]}, :require => :loggedin
      map.permission :edit_item, {:items => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_item, {:items => [:destroy]}, :require => :loggedin
  end

  map.feature_module :statuses do |map|
      map.permission :view_status, {:statuses => [:show, :index]}, :require => :loggedin
      map.permission :search_status, {:statuses => [:index]}, :require => :loggedin
      map.permission :add_status, {:statuses => [:new, :create]}, :require => :loggedin
      map.permission :edit_status, {:statuses => [:edit, :update]}, :require => :loggedin
      map.permission :destroy_status, {:statuses => [:destroy]}, :require => :loggedin
  end
end

