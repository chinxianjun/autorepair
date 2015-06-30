#coding: utf-8
class PasswordsController < Devise::PasswordsController
  before_filter :authenticate_manager!

  def edit
    @manager = current_manager
  end

  def update
    @manager = current_manager

    if @manager.update_with_password(params[:user])
      sign_in(@manager, :bypass => true)
      redirect_to admin_companies_path, :notice => "Password updated!"
    else
      render :edit
    end
  end
end