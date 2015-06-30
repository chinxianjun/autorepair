#coding: utf-8
class RegistrationsController < Devise::RegistrationsController
  # To use later_dude calendar
  helper LaterDude::CalendarHelper


  def new
    super
  end

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        #sign_in(resource_name, resource)
        #respond_with resource, :location => redirect_location(resource_name, resource)
        #如果是admin, 创建用户后重定向到/home/superadmin
        if resource_name.equal?(:manager)
          redirect_to superadmin_home_index_path
        #如果是user, 创建用户后重定向到/home/workflow
        elsif resource_name.equal?(:user)
          Group.first.users << resource
          redirect_to admin_users_path
        else
          redirect_to root_path
        end

      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
    end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    # If the user has filled in any of the password fields, we'll update their password
    any_passwords = %w(password password_confirmation current_password).any? do |field|
      params[resource_name][field].present?
    end
    update_method = any_passwords ? :update_with_password : :update_without_password

    if resource.send(update_method, params[resource_name])
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render_with_scope :edit }
    end
  end

  #protected
  #
  #  def after_update_path_for(resource)
  #    if resource_name.equal?(:user)
  #      user_path(resource)
  #    elsif resource_name.equal?(:manager)
  #      manager_path(resource)
  #    end
  #  end
end