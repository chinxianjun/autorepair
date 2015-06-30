class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
    respond_to do |format|
      format.html
      format.json { render :json => @budgets }
    end
  end

  def show
    @budget = Budget.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @budget }
    end
  end

  def new
    @budget = Budget.new
    respond_to do |format|
      format.html
      format.json { render :json => @budget }
    end
  end

  def create
    @budget = Budget.new(params[:budget])
    respond_to do |format|
      if @budget.save
        format.html
        format.json { render :json => @budget, :status => :created }
      else
        fomat.html { render "new" }
        format.json { render :json => @budget.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @budget = Budget.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @budget }
    end
  end

  def update
    @budget = Budget.find(params[:id])
    respond_to do |format|
      if @budget.update_attributes(:params[:budget])
        format.html
        formt.json { render :json => @budget, :status => :ok }
      else
        format.html { render "edit" }
        format.json { render :json => @budget, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    respond_to do |format|
      #format.html { redirect_to customers_index_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end
end
