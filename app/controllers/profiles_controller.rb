#coding: utf-8
class ProfilesController < ApplicationController
  respond_to :html, :json
  before_filter :current_user
  before_filter :authenticate_user!

  def index
    @profiles = current_user.profile
    respond_with(@profiles)
  end
  #
  def show

  end

  def new
    @profile = current_user.profile.new
    respond_with(@profile)
  end

  def create
    @profile = current_user.profile.new(params[:profile])
    if @profile.save
      redirect_to (profiles_path)
    else
      render :action => :new
    end
  end

  def edit
    @profile = current_user.profile.find(params[:id])
  end

  def update
    @profile = current_user.profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to (profiles_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    @profile = current_user.profile.find(params[:id])
    @profile.destroy

    respond_with(@profile)
  end
end
