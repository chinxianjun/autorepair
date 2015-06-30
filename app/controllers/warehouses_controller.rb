#coding: UTF-8
class WarehousesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :warehouse_auth
  helper_method :sort_column, :sort_direction
  before_filter :current_company, :only => [:show]

  layout :warehouse_layout

  def index
    @warehouses = Warehouse.paginate(:page=> params[:page], :per_page=> 10)
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    @company = @current_company
    oldparts = @warehouse.oldparts

    #@drawing_uniq = Oldpart.select(:drawing).uniq
    @drawing_uniq = []
    oldparts.each do |ops|
      @drawing_uniq << ops
      if @drawing_uniq.size >= 2
        if @drawing_uniq[-1].drawing === @drawing_uniq[-2].drawing
          @drawing_uniq.delete_at(-2)
        end
      end
    end

    @drawing_uniq = @drawing_uniq.paginate(:page=> params[:page], :per_page=> 10)

    @sum = 0
    @overflow = 0
    @stockout = 0

    oldparts.each do |o|
      @sum += o.price
    end

    respond_to do |format|
      #format.json
      format.html
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @warehouse = Warehouse.find(params[:id])
    @warehouses = @company.warehouses
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    @company = Company.find(params[:company_id])
    @warehouse = Warehouse.find(params[:id])
    respond_to do |format|
      if @warehouse.update_attributes(params[:warehouse])
        format.html {redirect_to setting_admin_company_path(@company)}
      else
        format.html {render "edit"}
      end
    end
  end

  def new
    @warehouse = Warehouse.new
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def create
    @warehouse = Warehouse.where(:name => params[:warehouse][:name], :category => params[:warehouse][:category]).first
    @company = Company.find(params[:company_id])
    if @company.warehouses.include?(@warehouse)
      respond_to do |format|
        format.json {render :json=>@warehouse.errors, :status => :unprocessable_entity}
      end
    else
      @warehouse = Warehouse.new(params[:warehouse])
      respond_to do |format|
        if @warehouse.save
          @warehouse.company = @company
          #format.html{redirect_to "/warehouses"}
          format.json {render :json => @warehouse, :status => :created}
        else
          #format.html{render "new"}
          format.json { render :json=> @warehouse.errors, :status => :unprocessable_entity}
        end
      end
    end
  end

  def destroy
    @company = Company.find(params[:company_id])
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy

    respond_to do |format|
      #format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def settings
    @company = Company.find(params[:company_id])
    @warehouse = Warehouse.find(params[:id])
    @member = @warehouse.members
  end

  # def neighbor
  #   @warehouse = Warehouse.find(params[:id])
  #   if request.post?

  #   end
  # end

  def search
    @warehouse = Warehouse.find(params[:id])
    @oldparts = @warehouse.oldparts.where('name LIKE ? OR drawing LIKE ? OR factory LIKE ? OR factory_code LIKE ?', "%#{params[:column]}%", "%#{params[:column]}%", "%#{params[:column]}%", "%#{params[:column]}%", "%#{params[:column]}%")
    #dishcates_ids = store.dishcates.collect{|f| f.id}
    respond_to do |format|
      format.json { render :json=> @oldparts.as_json(:only => [:name])}
      format.js
    end
  end

  #def members
  #  @company = Company.find(params[:company_id])
  #  @warehouse = Warehouse.find(params[:id])
  #  @members = @warehouse.members
  #  repond_to do |format|
  #    format.html
  #  end
  #end

  def new_users
    @warehouse = Warehouse.find(params[:id])
    @users = User.all - @warehouse.users
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render  :json => {
          :users => @users,
          :warehouse => @warehouse,
          :company_id => @company.id
      }
      }
    end
  end

  def create_users
    @warehouse = Warehouse.find(params[:id])
    @company = Company.find(params[:company_id])

    #group and user create association
    @warehouse.user_ids = params[:user_ids]
    #company and user create association
    @company.user_ids = params[:user_ids]

    #setting default company for user
    @company.users.each do |user|
      if user.default_company.nil?
        user.update_attributes(:default_company => user.companies.first.id)
      end
    end
    respond_to do |format|
      format.html
      format.json { render :json => @warehouse, :status => :created }
    end
  end

  def new_roles
    @warehouse = Warehouse.find(params[:id])
    @roles = Role.all - @warehouse.roles
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html
      format.json { render  :json => {
          :roles => @roles,
          :warehouse => @warehouse,
          :company_id => @company.id
      }
      }
    end
  end

  def create_roles
    @warehouse = Warehouse.find(params[:id])
    @company = Company.find(params[:company_id])
    @warehouse.role_ids = params[:role_ids]

    respond_to do |format|
      format.html
      format.json { render :json => @warehouse, :status => :created }
    end
  end

  def follows
    @warehouses = Warehouse.all
    @warehouse = Warehouse.find(params[:id])
    @company = @warehouse.company
    @follows = @warehouse.follows

    if request.post?
      @warehouse.follows = params[:follows][@warehouse.id.to_s]
      @warehouse.save

      redirect_to setting_admin_company_path(@company)
    end
  end

  private

  def sort_column
    Warehouse.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def warehouse_layout
    current_user.admin? ? "admin" : "user"
  end

  def warehouse_auth
    current_user.admin? ? :authorize : :require_admin
  end
end
