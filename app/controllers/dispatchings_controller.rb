#coding: utf-8
class DispatchingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  # GET /dispatchings
  # GET /dispatchings.json
  layout "user"

  def index
    @dispatchings = Dispatching.all
    @workflows = @current_company.workflows.where(:status => "dispatch")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @dispatchings }
    end
  end

  def dispatch_flow
    @repairer = @current_company.repairer

    @vehicles = Vehicle.all
    @faults = Fault.all
    @my_dispatchings = []

    dispatch_count = 0
    vehicle_count = 0
    fault_count = 0
    oldpart_count = 0
    newpart_count = 0
    report_count = 0
    expense_count = 0
    # get workflow tabs value
    @workflows = @current_company.workflows
    @workflows.each do |workflow|
      case workflow.status
        when "dispatch"
          @my_dispatchings << workflow.dispatching unless workflow.dispatching.nil?
          dispatch_count += 1
        when "vehicle"
          vehicle_count += 1
        when "fault"
          fault_count += 1
        when "oldpart"
              oldpart_count += 1
        when "newpart"
              newpart_count += 1
        when "report"
          report_count += 1
        when "expense"
          expense_count += 1
        else
      end
    end

    respond_to do |format|
      format.html
      format.json { render :json=>
          {
            :dispatch_count => dispatch_count,
            :vehicle_count => vehicle_count,
            :fault_count => fault_count,
            :oldpart_count => oldpart_count,
            :newpart_count => newpart_count,
            :report_count => report_count,
            :expense_count => expense_count
         }
      }
    end
  end

  # GET /dispatchings/1
  # GET /dispatchings/1.json
  def show
    @dispatching = Dispatching.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @dispatching }
    end
  end

  # GET /dispatchings/new
  # GET /dispatchings/new.json
  def new
    @dispatching = Dispatching.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @dispatching }
    end
  end

  # POST /dispatchings
  # POST /dispatchings.json
  def create
    @dispatching = Dispatching.new(params[:dispatching])

    respond_to do |format|
      if @dispatching.save
        #format.html { redirect_to @dispatching, notice: 'Dispatching was successfully created.' }
        format.json { render :json => @dispatching, :status => :created }
      else
        #format.html { render :action => "new" }
        format.json { render :json=> @dispatching.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # GET /dispatchings/1/edit
  def edit
    @dispatching = Dispatching.find(params[:id])
    @workflow = @dispatching.workflow
    @customer = @workflow.customer_workflow.customer
    @repairer = @current_company.repairer
    respond_to do |format|
      format.html
      format.json { render :json => @dispatching }
    end
  end

  # PUT /dispatchings/1
  # PUT /dispatchings/1.json
  def update
    @dispatching = Dispatching.find(params[:id])
    workflow = @dispatching.workflow
    respond_to do |format|
      if params[:warranty] == "进厂"
        if @dispatching.update_attributes(params[:dispatching])
          workflow.update_attributes(:status => "vehicle")
          workflow.user_ids = params[:repairman_ids]
          workflow.users.each do |user|
            user.update_attributes(:status => "busy")
          end
          format.json { head :ok }
        else
          format.json { render :json => @dispatching.errors, :status => :unprocessable_entity }
        end
      elsif params[:warranty] == "救援"
        if @dispatching.update_attributes(params[:dispatching])
           workflow.update_attributes(:status => "newpart")
           format.json {head :ok}
        else
           format.json { render :json => @dispatching.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def budget
    @dispatching = Dispatching.find(params[:id])
    @budgets = @dispatching.budgets
    @workflow = Workflow.find(params[:wid])
    @vehicle = @workflow.vehicle_workflowship.vehicle
    @customer = @workflow.customer_workflow.customer
    @categories = current_company.warehouses.where(:category=>"新件").map{|n| [n.name]}.uniq
    @names = Newpart.all.map{|o| [o.name]}.uniq
    @drawings = Newpart.all.map{|o| [o.drawing]}.uniq
    @price = Newpart.all.map{|o| [o.price]}.uniq
    if request.post?
      budget = Budget.new(params[:budget])
      respond_to do |format|
        if budget.save
          @dispatching.budgets << budget
          format.html
          format.json { render :json => @dispatching }
        else
          format.html
        end
      end
    end
  end

  # DELETE /dispatchings/1
  # DELETE /dispatchings/1.json
  def destroy
    @dispatching = Dispatching.find(params[:id])
    @dispatching.destroy
    @workflow = @dispatching.workflow
    respond_to do |format|
      format.html { redirect_to dispatchings_url }
      format.json { head :ok }
      formt.js
    end
  end

  def budget_del
    @budget = Budget.find(params[:budget_id])
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :nothing => true }
    end
  end

  #def repairer
  #  @dispatching = Dispatching.find(params[:id])
  #  @repairer = @current_company.repairer
  #  if request.post?
  #    @dispatching.repairer = params[:repairer]
  #    @dispatching.update_attributes
  #  end
  #end
end
