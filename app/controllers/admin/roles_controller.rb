#coding: utf-8
require 'jartai'
class Admin::RolesController < ApplicationController
  before_filter :authenticate_user!
  #include LoginSystem
  
  before_filter :require_admin
  layout "admin"
  #verify :method => :post, :only => [ :destroy, :move ],
  #       :redirect_to => { :action => :index }
  #respond_to :html, :json

  def index
    @roles = Role.paginate(:page =>  params[:page],  :per_page  => 10).order("id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @roles }
    end
  end

  def show
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @role }
    end
  end

  def new
    @role = Role.new
    respond_to do |format|
      #format.html # new.html.erb
      format.json { render :json => @role }
    end
  end

  def create
    @role = Role.new(params[:role])
    respond_to do |format|
      if @role.save
        #format.html { redirect_to roles_path, notice: 'Role was successfully created.' }
        format.json { render :json => @role, :status => :created }
      else
        #format.html { render action: "new" }
        format.json { render :json => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to admin_roles_path, :notice => 'Role was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render  :action => "edit" }
        format.json { render :json => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end
  
  def report
    @roles = Role.all
    @role = Role.find(params[:id])
    @permissions = Jartai::AccessControl.permissions

    if request.post?
        @role.permissions = params[:permissions][@role.id.to_s]
        @role.save

        redirect_to :action => 'index'
    end
  end
end