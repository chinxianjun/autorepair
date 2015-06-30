#coding: utf-8
class NewpartBaseController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :authorize
  before_filter :current_company

  layout "user"

  def index
    @brands = Brand.all
    @definitions = Definition.all
    @drawing_numbers = DrawingNumber.all
    respond_to do |format|
      format.html
    end
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
