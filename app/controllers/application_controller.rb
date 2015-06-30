#coding: utf-8
class ApplicationController < ActionController::Base

  helper :all
  protect_from_forgery
  #before_filter :authenticate_user!
  #before_filter :current_company

  #To use catch exception
  rescue_from ActiveRecord::ConnectionNotEstablished, :with => :render_404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def require_login
    if !user_signed_in?
      if request.get?
        url = url_for(params)
      else
        url = url_for(:controller => params[:controller], :action => params[:action], :id => params[:id])
      end
      return false
    end
    true
  end

  def require_admin
    return unless require_login
    if !current_user.admin?
      render_403
      return false
    end
    true
  end

  def deny_access
    user_signed_in? ? render_403 : require_login
  end

  # Authorize the user for the requested action
  def authorize(ctrl = params[:controller], action = params[:action])
    company = current_company
    company_groups = company.groups
    current_groups = company_groups & current_user.groups
    if company.nil?
      allowed = false
    elsif current_user.groups.nil?
      allowed = false
    elsif current_groups
      allowed = current_user.allowed_to?(current_user, {:controller => ctrl, :action => action}, company)
    else
      allowed = false
    end

    allowed ? true : deny_access
  end

  def authorize_global(ctrl = params[:controller], action = params[:action], company_id = params[:company_id])
    company = Company.find(company_id)

    if company.nil?
      allowed = false
    elsif current_user.nil?
      allowed = false
    else
      allowed = current_user.allowed_to?(current_user, {:controller => ctrl, :action => action}, company)
    end

    allowed ? true :deny_access
  end

  def render_403(options={})
    #render_error({message: I18n.t('txt.notice_not_authorized'),  status: 403}.merge(options))
    respond_to do |format|
      format.html { render "common/403" }
      format.json { render :status => 403 }
    end
    #return false
  end

  def render_404(options={})
    respond_to do |format|
      format.html { render "common/404" }
      format.json { render :status => 404 }
    end
  end

  # Renders an error response
  def render_error(arg)
    arg = {:message => arg} unless arg.is_a?(Hash)

    @message = arg[:message]
    @message = I18n.t(@message) if @message.is_a?(Symbol)
    @status = arg[:status] || 500

    respond_to do |format|
      format.html {
        render  :template => 'common/error', :status => @status
      }
      format.atom { head @status }
      format.xml { head @status }
      format.js { head @status }
      format.json { head @status }
    end
  end

  # 设置默认的公司,保存值为公司id：id
  def default_company=(company_id)
    current_user.update_attributes(:default_company => company_id)
  end
  #
  def default_company
    current_user.default_company
  end
  ## 设置当前的公司
  #def current_company=(company)
  #  @current_company  = company
  #end
  ##获取当前公司，初始值为默认公司
  #def current_company
  #  @current_company ||= current_user.default_company
  #end

  def current_company
    if params[:JCompanyID].nil?
      if current_user.default_company.nil?
        @current_company = current_user.companies.first
      else
        @current_company = Company.find(current_user.default_company)
      end
    else
      @current_company = Company.find(params[:JCompanyID])
    end
  end


  private

  def after_sign_out_path_for(resource_or_scope)
    # logic here
    home_index_path
  end

  #def after_sign_in_path_for(resource)
  #  if resource.admin?
  #    puts "admin sign in"
  #    redirect_to admin_companies_path
  #  else
  #    puts "user sign in"
  #    redirect_to login_home_index_path
  #  end
  #end
end
