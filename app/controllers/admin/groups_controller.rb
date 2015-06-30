# encoding: utf-8
class Admin::GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  layout "admin"
  #respond_to :html, :xml, :json

  def index
    @company = Company.find(params[:company_id])
    @groups = @company.groups.order("id")
    respond_to do |format|
      format.html #{ redirect_to admin_companies_path } # index.html.erb
      #format.json { render json: {
      #    :groups => @mygroups
      #}
      #
    end
  end

  def show
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.json { render :json => @group }
    end
  end

  def new
    @group = Group.new
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render  :json => {
          :group => @group,
          :company_id => @company.id
          }
      }
    end
  end

  def create
    @group = Group.new(params[:group])
    @company = Company.find(params[:company_id])

    respond_to do |format|
      if @group.save
        @company.groups << @group
        #format.html { redirect_to admin_groups_path }
        format.json { render  :json => @group, :status => :created }
      else
        #format.html { render action: "new" }
        format.json { render  :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.json { render :json => @group }
    end
  end

  def update
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])
    if @group.update_attributes(params[:group])
      flash[:notice] = 'update_success'
      respond_to do |format|
        format.html { redirect_to setting_admin_company_path(@company) }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :action =>  :edit }
        format.json { render :json => @group.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { render :status => 200 }
      format.js { render :nothing => true }
    end
  end

  #def autocomplete_for_user
  #  @group = Group.find(params[:id])
  #  @users = User.find(:all, :limit => 100) - @group.users
  #  render :layout => false
  #end

  def new_users
    @group = Group.find(params[:id])
    @users = User.all - @group.users
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => {
          :users => @users,
          :group => @group,
          :company_id => @company.id
      }
    }
    end
  end

  def create_users
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])

    #group and user create association
    @group.user_ids = params[:user_ids]
    #company and user create association
    @company.users << User.find(params[:user_ids])

    #setting default company for user
    @company.users.each do |user|
      if user.default_company.nil?
        user.update_attributes(:default_company => user.companies.first.id)
      end
    end
    respond_to do |format|
      format.html
      format.json { render :json => @group, :status => :created }
    end
  end

  def new_roles
    @group = Group.find(params[:id])
    @roles = Role.all - @group.roles
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.json { render :json => {
          :roles => @roles,
          :group => @group,
          :company_id => @company.id
      }
    }
    end
  end

  def create_roles
    @group = Group.find(params[:id])
    @company = Company.find(params[:company_id])
    @group.role_ids = params[:role_ids]

    respond_to do |format|
      format.html
      format.json { render :json => @group, :status => :created }
    end
  end
end
