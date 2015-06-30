#coding: UTF-8
class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  helper_method :sort_column, :sort_direction
  layout "user"

  def index
    @items = Item.search(params[:column]).order(sort_column + " " + sort_direction).paginate(:page=> params[:page], :per_page=> 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      @item = Item.where(:name => params[:item][:name], :code => params[:item][:code]).first
      if @item
        format.html {render "edit",  :notice => "配件厂家已存在."}
      else
        if @item.update_attributes(:params[:item])
          format.html {redirect_to "/items"}
        else
          format.html {render "edit"}
        end
      end
    end
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @item = Item.where(:name => params[:item][:name], :code => params[:item][:code]).first

    if @item
      respond_to do |format|
        format.json {render :json=>@item.errors, :status => :unprocessable_entity}
      end
    else
      @item = Item.new(params[:item])
      respond_to do |format|
        if @item.save
          @item.company=current_company
          #format.html{redirect_to "/items"}
          format.json {render :json => @items, :status => :created}
        else
          #format.html{rendor "new"}
          format.json { render :json=> @items.errors, :status => :unprocessable_entity}
        end
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      #format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  private

  def sort_column
    Customer.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
