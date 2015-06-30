AutoRepair::Application.routes.draw do

  resources :questions do
    collection do
      get :repair
      get :buy_car
      get :buy_part
      get :consulting
      get :complaint
      get :search_vehicle
      post :managers
      get :repair_new
      post :repair_new
      get :buy_car_new
      post :buy_car_new
      get :buy_part_new
      post :buy_part_new
      get :consulting_new
      post :consulting_new
      get :complaint_new
      post :complaint_new
    end
    resources :consultings, :complaints
    resources :part_buyings do
      member do
        get 'add_salesman'
        post 'add_salesman'
      end
    end
    resources :car_buyings do
      member do
        get 'add_salesman'
        post 'add_salesman'
      end
    end
  end
  resources :workflows do
    collection do
      get :workflow_flow
      get :home
    end
  end
  resources :reports do
    collection do
      get :search
      get :report_flow
      get :getflow
    end
  end

  resources :faults do
    collection do
      get :search
      get :fault_flow
      post :ind_fault_create
      get :ind_fault_edit
      put :ind_fault_update
      get :ind_fault_destroy
      put :finished
    end
  end

  resources :expenses do
    collection do
      get :search
      get :expense_flow
    end
  end

  resources :dispatchings do
    collection do
      get :search
      get :dispatch_flow
    end
    member do
      get 'budget'
      post 'budget'
      get 'budget_del'
    end
  end

  resources :customers do
    collection do
      post :search
      get :business
      get :category
      post :category
      put :category
      get :add_user
      post :add_user
      get :category_destroy
      post :level
    end
    #resources :categories, :only => [:destroy]
  end

  resources :oldparts do
    collection do
      get :oldpart_search
      get :ind_index
      get :ind_show
      get :ind_new
      post :ind_create
      get :ind_edit
      put :ind_update
      delete :ind_destroy
      get :oldpart_flow
    end
  end

  resources :newparts do
    collection do
      get :newpart_search
      get :newpart_flow
      get :receive
      put :receive_finish
    end
  end

  #resources :items

  resources :vehicles do
    collection do
      get :vehicle_flow
      get :search
    end
    member do
      get 'owner_new'
      post 'owner_create'
      get 'owner_edit'
      put 'owner_update'
      get 'owner_show'
      delete 'owner_destroy'
    end
  end

  resources :messages do
    collection do
      get :account
      get :send_msg
      get :multi_send_msg
      get :company_message
      get :customer_message
      get :multi_messages
      get :history
      post :history
    end
  end

  #resources :statuses

  #devise_for :managers,
  #           :path => "managers",
  #           :controllers => {
  #               :registrations => "registrations",
  #               :passwords => "passwords",
  #               :sessions => "sessions"
  #           }

  devise_for :users,
             :path => "users",
             :controllers => {
                 :registrations => "registrations",
                 :passwords => "passwords",
                 :sessions => "sessions"
             } do
                get 'users', :to => 'users#show', :as => :user_show
             end
  #devise_for :admins, :users

  namespace :admin do
    resources :companies do
      member do
        get 'setting'
        get 'new_repairers'
        post 'create_repairers'
        get 'new_salesmen'
        post 'create_salesmen'
      end
      resources :groups do
        member do
          get 'new_users'
          post 'create_users'
          get 'new_roles'
          post 'create_roles'
        end
      end
    end
    resources :users do
      member do
        get 'password_edit'
        put 'password_update'
      end
    end
    #resources :managers, :only => [:show, :edit, :update] do
    #  member do
    #    get 'password_edit'
    #    put 'password_update'
    #  end
    #end
    resources :roles do
      member do
        get 'report'
        post 'report'
      end
    end
  end

  resources :warehouses do
    member do
      get 'new_users'
      post 'create_users'
      get 'new_roles'
      post 'create_roles'
      get 'settings'
      get 'follows'
      post 'follows'
    end

    resources :members, :only => [:index, :show, :edit, :create, :update, :destroy]

    resources :oldparts do
      collection do
        get :oldpart_search
        get :ind_index
        get :ind_show
        get :ind_new
        post :ind_create
        get :ind_edit
        put :ind_update
        delete :ind_destroy
        get :oldpart_flow
      end
      member do
        get :oldpart_out
        post :oldpart_out
      end
    end

    resources :newparts do
      collection do
        get :newpart_search
        get :newpart_flow
        get :receive
        put :receive_finish
      end
    end
  end

  resources :newparts do
    collection do
      get :newpart_search
      get :newpart_flow
      get :receive
      put :receive_finish
    end
  end

  resources  :home, :only => [:index] do
    collection do
      get :superadmin
      get :admin
      get :forbidden
      get :login
    end
  end

  #resources :my, :only => [:index]  do
  #  collection do
  #    get :setting
  #    post :setting
  #  end
  #end

  root :to => 'home#index'

end
