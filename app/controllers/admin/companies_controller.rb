#coding: utf-8
class Admin::CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  layout "admin"
  def index
    @companies = Company.paginate(:page =>  params[:page],  :per_page => 10).order("id")
  end

  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @company }
    end
  end

  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @company }
    end
  end

  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        @company.create_repairer(:name => @company.company_code)
        @company.create_salesman(:name => @company.company_code)
        current_user.companies << @company
        #format.html { redirect_to admin_companies_path, notice: 'Company was successfully created.' }
        format.json { render :json => @company, :status => :created }
      else
        format.html { render :action => "new" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to admin_companies_path, :notice => 'Company was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => ([:admin,@company]).errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to admin_companies_url }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def setting
    @company = Company.find(params[:id])
    @repairer = @company.repairer
    @salesman = @company.salesman
    @groups = @company.groups.order("id")
    @stores = @company.warehouses

    respond_to do |format|
      format.html
      format.json { render :json => @company }
    end
  end

  def new_repairers
    @company = Company.find(params[:id])

    if @company.repairer.nil?
      @company.create_repairer(:name => @company.company_code)
    end
    @repairer = @company.repairer
    @users = User.all - @repairer.users

    respond_to do |format|
      format.html
      format.json {
        render :json => {
            :company => @company,
            :repairer => @repairer,
            :users => @users
        }
      }
    end
  end

  def create_repairers
    @company = Company.find(params[:id])
    @repairer = @company.repairer

    @repairer.user_ids = params[:user_ids]

    respond_to do |format|
      format.html
      format.json { render :json => @repairer, :status => :created }
    end
  end

  def new_salesmen
    @company = Company.find(params[:id])

    if @company.salesman.nil?
      @company.create_salesman(:name => @company.company_code)
    end
    @salesman = @company.salesman
    @users = User.all - @salesman.users

    respond_to do |format|
      format.html
      format.json {
        render :json => {
            :company => @company,
            :repairer => @repairer,
            :users => @users
        }
      }
    end
  end

  def create_salesmen
    @company = Company.find(params[:id])
    @salesman = @company.salesman

    @salesman.user_ids = params[:user_ids]

    respond_to do |format|
      format.html
      format.json { render :json => @salesman, :status => :created }
    end
  end
end