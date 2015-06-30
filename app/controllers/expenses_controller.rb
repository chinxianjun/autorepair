#coding: utf-8
class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  # GET /expenses
  # GET /expenses.json
  respond_to :html, :json
  layout "user", :except => [:expense_flow]

  def index
    @expenses = Expense.paginate(page:  params[:page],  per_page: 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  def expense_flow
    @expenses = Expense.paginate(page:  params[:page],  per_page: 5)
    @workflow_expense = @current_company.workflows(:status => "expense")
    dispatch_count = 0
    vehicle_count = 0
    fault_count = 0
    oldpart_count = 0
    newpart_count = 0
    report_count = 0
    expense_count = 0

    @workflows = @current_company.workflows
    @workflows.each do |workflow|
      case workflow.status
        when "dispatch"
          dispatch_count += 1
        when "vehicle"
          vehicle_count += 1
        when "fault"
          fault_count += 1
        when "oldpart"
          workflow.faults.each do |faults|
            if faults.measure == "replace"
              oldpart_count += 1
            end
          end
        when "newpart"
          workflow.faults.each do |faults|
            if faults.measure == "replace"
              newpart_count += 1
            end
          end
        when "report"
          report_count += 1
        when "expense"
          expense_count += 1
        else
      end
    end

    respond_to do |format|
      format.html
      format.json { render json:
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

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @workflow = Workflow.find(params[:wid])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    @workflow = Workflow.find(params[:wid])

    respond_to do |format|
      if @expense.save
        @workflow.expense=@expense
        @workflow.update_attributes(:status => "finished")
        @workflow.repairmen.each do |re|
          re.user.update_attributes(:status => 'idle')
        end
        format.html { redirect_to  workflow_flow_workflows_path, notice: 'Expense was successfully created.' }
        format.json { render :json => @expense, :status => :created }
      else
        #format.html { render action: "new" }
        format.json { render :json => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    respond_to do |format|
      #format.html
      format.json { render :json => @expense }
    end
  end


  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        #format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :ok }
      else
        #format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html
      format.json { render head :ok }
      format.js { render :nothing => true }
    end
  end
end
