class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  layout "admin"

  def index
    @warehouse = Warehouse.find(params[:warehouse_id])
    @company = @warehouse.company
    @members = @warehouse.members
    @member_users = Array.new
    @member_groups = Array.new

    if @members
      @members.each do |m|
        if m.user_id
          @member_users << User.find(m.user_id)
        elsif m.group_id
          @member_groups << Group.find(m.group_id)
        end
      end
    end

    @users = User.all
    @roles = Role.all
    @groups = @company.groups

    respond_to do |format|
      format.html
    end
  end

  def show
    @warehouse = Warehouse.find(params[:warehouse_id])
    @company = @warehouse.company
    @member = Member.find(params[:id])
    @roles = Role.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @member = Member.new
  end

  def create
    @warehouse = Warehouse.find(params[:warehouse_id])
    @company = @warehouse.company

    warehouse_members = []
    if params[:membership]
      if params[:membership][:user_ids]
        attrs = params[:membership].dup
        user_ids = attrs.delete(:user_ids)

        user_ids.each do |user_id|
          warehouse_members << Member.new(:role_ids => params[:membership][:role_ids], :user_id => user_id)
          @warehouse.users << User.find(user_id)
        end
      elsif params[:membership][:group_ids]
        attrs = params[:membership].dup
        group_ids = attrs.delete(:group_ids)

        group_ids.each do |group_id|
          warehouse_members << Member.new(:role_ids => params[:membership][:role_ids], :group_id => group_id)
          @warehouse.groups << Group.find(group_id)
        end
      end
      @warehouse.members << warehouse_members
    end

    respond_to do |format|
      format.html { redirect_to warehouse_members_path }
      #format.js { @members = warehouse_members }
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @warehouse = Warehouse.find(params[:warehouse_id])
    @company = @warehouse.company
    @roles = Role.all
    @member = Member.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.role_ids = params[:role_ids]
    respond_to do |format|
      format.html {redirect_to admin_company_warehouse_members_path}
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
end
