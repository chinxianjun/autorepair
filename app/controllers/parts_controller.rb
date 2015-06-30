#coding: UTF-8
class PartsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  helper_method :sort_column, :sort_direction
  #autocomplete_for :part, :name
  layout "user"

  def index
    @parts = Part.search(params[:column]).order(sort_column + " " + sort_direction).paginate(:page=> params[:page], :per_page=> 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @part = Part.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    respond_to do |format|
      @part = Part.where(:name => params[:part][:name], :category => params[:part][:category]).first
      if @part
        format.html {render "edit",  :notice => "配件库已存在."}
      else
        if @part.update_attributes(:params[:part])
          format.html {redirect_to "/parts"}
        else
          format.html {render "edit"}
        end
      end
    end
  end

  def new
    @part = Part.new
    @parts = Part.find(:all,:conditions => ['name LIKE ?', "#{params[:q]}%"],  :limit => 5, :order => 'name')
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def create
    @part = Part.where(:name => params[:part][:name], :category => params[:part][:category]).first

    if @part
      respond_to do |format|
        format.json {render :json=>@part.errors, :status => :unprocessable_entity}
      end
    else
      @part = Part.new(params[:part])
      respond_to do |format|
        if @part.save
          @part.company=current_company
          #format.html{redirect_to "/parts"}
          format.json {render :json => @parts, :status => :created}
        else
          #format.html{rendor "new"}
          format.json { render :json=> @parts.errors, :status => :unprocessable_entity}
        end
      end
    end
  end

  def destroy
    @part = Part.find(params[:id])
    @part.destroy

    respond_to do |format|
      #format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def search_parts
    @part = Part.find(:all,:conditions => ['name LIKE ?', "%#{params[:q]}%"], :order => 'name')
    #dishcates_ids = store.dishcates.collect{|f| f.id}
    respond_to do |format|
      format.json { render :json=> @part.as_json(:only => [:name])}
      format.js
    end
  end
  #def  autocomplete_for
  #
  #autocomplete_for :part, :name do |items,method|
  #  render :text => items.map{|item| "#{item.send(method)} -- #{item.id}"}.join("\n")
  #end

  private

  def sort_column
    Customer.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
