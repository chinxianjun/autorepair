#coding: utf-8

class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  before_filter :require_admin, :except => [:password_edit, :password_update]
  layout "admin", :except => [:password_edit]
  # layout "user", :only => [:password_edit]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10).order("id")

    respond_with do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new
    if current_user.admin?
      @company = current_user.companies.first
    end
    respond_to do |format|
      format.html
    end
  end

  def create
    @user = User.new(params[:user])
    if current_user.admin?
      @company = current_user.companies.first
    end
    respond_to do |format|
      if @user.save
        @user.companies << @company
        #format.html {reditect_to "/admin/users"}
        format.json { render :json => @user, :status => :created }
      else
        #format.html { render "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.admin?
      @company = current_user.companies.first
    else
      #need add simple user's  function
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if @user.companies.size == 0
          @user.companies << @company
        end
        format.html { redirect_to admin_users_path }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if !current_user.admin?
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url }
        format.json { head :ok }
        format.js { render :nothing => true }
      end
    else
      respond_to do |format|
        format.json { head :ok }
        format.js :js => "alert('You Don't destroy a manager account.);"
      end
    end
  end

  def setting(company)
    @user = current_user
    @user.default_company = company
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def password_edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def password_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html
        format.json { head :ok }
      else
        format.html { render "password_edit" }
      end
    end
  end
end
