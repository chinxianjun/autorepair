# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130510072348) do

  create_table "borrows", :force => true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "drawing"
    t.string   "price"
    t.integer  "count"
    t.string   "factory"
    t.string   "factory_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "brands", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "budget_parts", :force => true do |t|
    t.string   "name"
    t.string   "drawing"
    t.float    "price"
    t.string   "factory"
    t.string   "newpart_manage"
    t.string   "running_number"
    t.string   "factory_code"
    t.integer  "count"
    t.string   "category"
    t.string   "receiver"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "budgets", :force => true do |t|
    t.float    "service_car_cost"
    t.float    "working_hours_cost"
    t.float    "material_cost"
    t.float    "total"
    t.string   "creator"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "category"
    t.string   "name"
    t.string   "drawing"
    t.integer  "count"
    t.float    "price"
    t.string   "factory"
    t.string   "factory_code"
    t.string   "three_bags"
  end

  create_table "car_buying_questionships", :force => true do |t|
    t.integer  "car_buying_id"
    t.integer  "question_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "car_buyings", :force => true do |t|
    t.string   "factory"
    t.string   "kind"
    t.string   "price_range"
    t.text     "description"
    t.string   "referral"
    t.string   "manager"
    t.string   "salesman"
    t.string   "status"
    t.text     "reason"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "creator"
  end

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "state"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "company_code"
    t.string   "simply"
  end

  create_table "company_groupships", :force => true do |t|
    t.integer  "company_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "company_workflows", :force => true do |t|
    t.integer  "company_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "complaint_questionships", :force => true do |t|
    t.integer  "complaint_id"
    t.integer  "question_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "complaints", :force => true do |t|
    t.string   "category"
    t.text     "description"
    t.string   "repair_number"
    t.string   "car_number"
    t.string   "defendant"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "creator"
    t.text     "measures"
    t.string   "manager"
  end

  create_table "consulting_questionships", :force => true do |t|
    t.integer  "consulting_id"
    t.integer  "question_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "consultings", :force => true do |t|
    t.string   "category"
    t.text     "answer"
    t.text     "question"
    t.string   "answerer"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "creator"
  end

  create_table "customer_categoryships", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_flows", :force => true do |t|
    t.string   "username"
    t.string   "gender"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "zipcode"
    t.datetime "birthday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customer_questionships", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_vehicleships", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_workflows", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "fullname"
    t.string   "gender"
    t.string   "phone"
    t.string   "address"
    t.date     "birthday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "phone_swap"
    t.integer  "age"
    t.string   "category"
  end

  create_table "definitions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dispatching_budgetships", :force => true do |t|
    t.integer  "dispatching_id"
    t.integer  "budget_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dispatching_workflows", :force => true do |t|
    t.integer  "dispatching_id"
    t.integer  "workflow_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "dispatchings", :force => true do |t|
    t.string   "repairer"
    t.string   "dispatcher"
    t.string   "reception"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "status"
    t.string   "customer_name"
    t.string   "customer_phone"
    t.string   "customer_phone_swap"
    t.text     "faultdesc_desc"
    t.string   "faultdesc_place"
    t.string   "faultdesc_car_number"
    t.string   "property"
    t.string   "service_car_number"
  end

  create_table "dispatchingships", :force => true do |t|
    t.integer  "dispatching_id"
    t.integer  "sub_dispatching_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "drawing_numbers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expense_companyships", :force => true do |t|
    t.integer  "expense_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expense_workflowships", :force => true do |t|
    t.integer  "expense_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "expenses", :force => true do |t|
    t.float    "material_cost"
    t.float    "working_hours_cost"
    t.float    "communication_cost"
    t.float    "service_cat_cost"
    t.float    "meal_cost"
    t.float    "travel_expense"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.float    "total"
    t.float    "service_car_cost"
    t.string   "info_worker"
  end

  create_table "fault_companyships", :force => true do |t|
    t.integer  "fault_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fault_indfaultships", :force => true do |t|
    t.integer  "fault_id"
    t.integer  "indfault_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "fault_workflowships", :force => true do |t|
    t.integer  "fault_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "faultdecs_questionships", :force => true do |t|
    t.integer  "faultdesc_id"
    t.integer  "question_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "faultdesc_customers", :force => true do |t|
    t.integer  "faultdesc_id"
    t.integer  "customer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "faultdesc_workflowships", :force => true do |t|
    t.integer  "faultdesc_id"
    t.integer  "workflow_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "faultdescs", :force => true do |t|
    t.string   "car_number"
    t.text     "description"
    t.string   "place"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "warranty"
    t.string   "chassis_number"
    t.float    "driving_range"
    t.string   "model"
    t.date     "purchase_on"
  end

  create_table "faults", :force => true do |t|
    t.string   "measure"
    t.text     "fault_analyse"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "fault_desc"
    t.string   "status"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "users"
    t.text     "roles"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "simply"
  end

  create_table "histories", :force => true do |t|
    t.string   "send_man"
    t.text     "receive_man"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "indfault_indirectpartships", :force => true do |t|
    t.integer  "indfault_id"
    t.integer  "indirectpart_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "indfaults", :force => true do |t|
    t.string   "measure"
    t.text     "fault_analyse"
    t.string   "creator"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "indirectpart_faultships", :force => true do |t|
    t.integer  "indirectpart_id"
    t.integer  "fault_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "indirectpart_workflowships", :force => true do |t|
    t.integer  "indirect_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "indirectparts", :force => true do |t|
    t.string   "ind_name"
    t.string   "ind_drawing"
    t.integer  "ind_count"
    t.string   "ind_factory"
    t.string   "ind_pattern"
    t.string   "ind_depot"
    t.string   "ind_status"
    t.string   "ind_occupy"
    t.datetime "ind_occupytime"
    t.datetime "ind_warehousing_at"
    t.datetime "ind_warehousing_on"
    t.string   "ind_running_number"
    t.string   "ind_category"
    t.string   "ind_factory_code"
    t.string   "ind_fault_desc"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "handiner"
    t.string   "oldpart_manager"
    t.string   "category"
    t.string   "classes"
  end

  create_table "item_companyships", :force => true do |t|
    t.integer  "item_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "manager_companyships", :force => true do |t|
    t.integer  "manager_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "managers", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username"
    t.string   "fullname"
    t.string   "phone"
    t.date     "birthday"
    t.string   "address"
    t.string   "gender"
  end

  add_index "managers", ["email"], :name => "index_managers_on_email", :unique => true

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "warehouse_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "group_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "phone"
    t.string   "customer"
    t.text     "content"
    t.string   "category"
    t.string   "creator"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "newflows", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newpart_companyships", :force => true do |t|
    t.integer  "newpart_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newpart_faultships", :force => true do |t|
    t.integer  "newpart_id"
    t.integer  "fault_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newpart_workflowships", :force => true do |t|
    t.integer  "newpart_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "newparts", :force => true do |t|
    t.string   "name"
    t.string   "drawing"
    t.float    "price"
    t.string   "factory"
    t.string   "newpart_manage"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "running_number"
    t.string   "factory_code"
    t.integer  "count"
    t.string   "category"
    t.string   "newpart_manager"
    t.string   "receiver"
    t.string   "uuid"
    t.string   "status"
  end

  create_table "oldpart_faultships", :force => true do |t|
    t.integer  "oldpart_id"
    t.integer  "fault_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "oldpart_indirectpartships", :force => true do |t|
    t.integer  "oldpart_id"
    t.integer  "indirectpart_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "oldpart_newpartships", :force => true do |t|
    t.integer  "oldpart_id"
    t.integer  "newpart_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "oldpart_warehouseships", :force => true do |t|
    t.integer  "oldpart_id"
    t.integer  "warehouse_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "oldpart_workflowships", :force => true do |t|
    t.integer  "oldpart_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "oldparts", :force => true do |t|
    t.string   "name"
    t.string   "drawing"
    t.integer  "count"
    t.string   "factory"
    t.string   "pattern"
    t.string   "depot"
    t.string   "status"
    t.string   "occupy"
    t.datetime "occupytime"
    t.datetime "warehousing_at"
    t.datetime "warehousing_on"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "running_number"
    t.string   "category"
    t.string   "factory_code"
    t.string   "fault_desc"
    t.string   "oldpart_manager"
    t.string   "handiner"
    t.string   "classes"
    t.float    "price"
    t.text     "note"
    t.integer  "parent_id"
    t.string   "uuid"
  end

  create_table "owners", :force => true do |t|
    t.string   "fullname"
    t.string   "phone"
    t.string   "address"
    t.string   "idcard"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "workplace"
  end

  create_table "part_buying_questionships", :force => true do |t|
    t.integer  "part_buying_id"
    t.integer  "question_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "part_buyings", :force => true do |t|
    t.string   "part_name"
    t.string   "part_drawing"
    t.string   "part_type"
    t.string   "factory_name"
    t.string   "factory_code"
    t.string   "count"
    t.string   "part_unit_price"
    t.string   "part_sub_total"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "creator"
    t.string   "referral"
    t.string   "salesman"
    t.string   "manager"
    t.string   "status"
  end

  create_table "part_companyships", :force => true do |t|
    t.integer  "part_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.string   "manager"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permssions", :force => true do |t|
    t.text     "permissions"
    t.integer  "role_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "phone"
    t.string   "address"
    t.date     "birthday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "category"
    t.string   "creator"
    t.string   "status"
    t.string   "processor"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.string   "salesman"
  end

  create_table "repairers", :force => true do |t|
    t.integer  "company_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "repairmen", :force => true do |t|
    t.integer  "workflow_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "repairs", :force => true do |t|
    t.string   "service_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "report_workflowships", :force => true do |t|
    t.integer  "report_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reports", :force => true do |t|
    t.string   "server_regist_number"
    t.string   "server_process_number"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "status"
    t.string   "infoman"
  end

  create_table "role_groupships", :force => true do |t|
    t.integer  "role_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "role_memberships", :force => true do |t|
    t.integer  "role_id"
    t.integer  "member_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "inherited_from"
  end

  create_table "role_warehouseships", :force => true do |t|
    t.integer  "role_id"
    t.integer  "warehouse_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "permissions"
    t.integer  "position",    :default => 1
    t.integer  "builtin",     :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "salesmen", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_dispatchings", :force => true do |t|
    t.string   "repairer"
    t.string   "dispatcher"
    t.string   "reception"
    t.string   "status"
    t.string   "customer_name"
    t.string   "customer_phone"
    t.string   "customer_phone_swap"
    t.text     "faultdesc_desc"
    t.string   "faultdesc_place"
    t.string   "faultdesc_car_number"
    t.string   "property"
    t.string   "creator"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "user_companyships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_groupships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_warehouseships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "warehouse_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "gender"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "fullname"
    t.string   "user_number"
    t.string   "phone"
    t.date     "birthday"
    t.string   "address"
    t.string   "default_company"
    t.integer  "repairer_id"
    t.string   "status",                 :default => "idle"
    t.integer  "salesman_id"
    t.string   "authentication_token"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vehicle_companyships", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vehicle_customerships", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "vehicle_ownerships", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vehicle_workflowships", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "workflow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "vehicles", :force => true do |t|
    t.string   "model"
    t.string   "chassis_number"
    t.string   "engine"
    t.string   "engine_number"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "order_number"
    t.string   "fast_type"
    t.string   "production_number"
    t.string   "first_bridge"
    t.string   "second_bridge"
    t.string   "third_bridge"
    t.string   "driving_range"
    t.date     "purchase_on"
    t.string   "warranty_card"
    t.string   "user_number"
    t.string   "car_number"
    t.string   "first_drive_shaft_drawing"
    t.string   "second_drive_shaft_drawing"
    t.string   "second_drive_shaft_code"
    t.string   "third_drive_shaft_drawing"
    t.string   "third_drive_shaft_code"
    t.string   "tank_drawing"
    t.string   "tank_code"
    t.string   "spring_drawing"
    t.string   "spring_code"
    t.string   "workplace"
    t.string   "gearbox_drawing"
    t.string   "gearbox_type"
    t.string   "fullname"
    t.string   "phone"
    t.string   "idcard"
    t.string   "address"
    t.string   "first_drive_shaft_code"
  end

  create_table "warehouse_companyships", :force => true do |t|
    t.integer  "warehouse_id"
    t.integer  "company_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "warehouses", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "manager"
    t.integer  "parent_id"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "identifier",   :limit => 20
    t.string   "homepage"
    t.integer  "lft"
    t.integer  "rgt"
    t.text     "neighbor_ids"
    t.text     "follows"
  end

  create_table "workflow_borrowships", :force => true do |t|
    t.integer  "workflow_id"
    t.integer  "borrow_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "workflow_budget_partships", :force => true do |t|
    t.integer  "workflow_id"
    t.integer  "budget_part_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "workflows", :force => true do |t|
    t.string   "description"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "creator"
    t.string   "oldparter"
    t.string   "newparter"
    t.string   "info_worker"
    t.string   "workflow_id"
    t.string   "repairman"
    t.string   "warranty"
    t.string   "flow_number"
  end

end
