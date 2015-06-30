#coding: utf-8

class Admin::ManagersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  layout "admin", :except => [:index]
  def show
    @manager = Manager.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @manager }
    end
  end

  def edit
    @manager = Manager.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @manager }
    end
  end

  def update
    @manager = Manager.find(params[:id])
    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        format.html { redirect_to admin_manager_path }
        format.json { head :ok }
      else
        format.html { render "edit" }
      end
    end
  end

  def password_edit
    @manager = Manager.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @manager }
    end
  end

  def password_update
    @manager = Manager.find(params[:id])
    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        format.html
        format.json { head :ok }
      else
        format.html { render "password_edit" }
        format.json { head :ok }
      end
    end
  end
end