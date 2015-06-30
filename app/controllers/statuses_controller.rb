class StatusesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  helper_method :sort_column, :sort_direction

  layout "user"

  def index
    @statuses = Status.search(params[:column]).paginate(page:  params[:page],  per_page: 5)

    respond_to do |format|
      format.html
    end
  end

  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @status = Status.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @status = Status.new(params[:status])
    respond_to do |format|
      if @status.save
        format.html
      else
        format.html {render "new"}
      end
    end
  end

  def edit
    @status = Status.find(:id)
    respond_to do |format|
      format.html
    end
  end

  def update
    @status = Status.find(:id)
    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html{redirect_to "/statuses"}
      else
        format.html{render "edit"}
      end
    end
  end

  def destroy
    @status = Status.find(:id)
    @status.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def sort_column
    Status.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
