#coding: utf-8
class SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token, :only => :create
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.html {
        resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        sign_in(resource_name, resource)
        if resource.save
          if resource.admin?
            redirect_to admin_companies_path
            puts "I am admin"
          else
            redirect_to login_home_index_path
            puts "I am user"
          end
        else
          redirect_to home_url
        end
      }
      format.json {
        resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
        #set_flash_message(:notice, :signed_in) if is_navigational_format?
        #sign_in(resource_name, resource)
        current_user.reset_authentication_token!
        if resource.save
          #render :status => 200, :json => resource
          render :json => {:respone => 'ok', :auth_token => current_user.authentication_token, :user => resource}.to_json, :status => :ok
        else
          render :json => resource.errors, :status => :unprocessable_entity
        end
      }
    end

    #respond_with resource, location:  redirect_location(resource_name, resource)

  end

end