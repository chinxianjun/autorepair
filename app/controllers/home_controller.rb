#coding: utf-8
class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :current_company
  before_filter :authorize, :only => [:login]
  layout "user", :only => [:login]

  def index
    respond_to do |format|
      format.html
      format.json {
        render :json => {:code => "hello!"}
      }
    end
  end

  def workflow

  end

  def admin

  end

  def login

  end

  def superadmin
    @managers = Manager.paginate(page:  params[:page],  per_page: 10)
    respond_to do |format|
      format.html
      format.json { render  :json => @managers }
    end

  end

  # def testRBAC
  #   @company = current_company
  # end

  # def forbidden
  # end
end
