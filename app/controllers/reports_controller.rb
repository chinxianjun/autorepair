#coding: utf-8
class ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  helper_method :sort_column, :sort_direction

  layout "user", :except => [:report_flow]
  def index
    @search = Report.all
    @reports = Report.search(params[:column]).order(sort_column + " " + sort_direction).paginate(:page=> params[:page], :per_page=> 10)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render :json=> {:reports => @reports} }
    end
  end

  def report_flow
    @workflow_report = @current_company.workflows.where(:status => "report")
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
      format.json { render :json =>
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

  def show

  end

  def new
    @report = Report.new
    @workflows = Workflow.all  #change to status == "未上报"

    respond_to do |format|
      format.html
      format.json { render :json => @report }
    end
  end

  def create
    @report = Report.new(params[:report])
    @workflow = Workflow.find(params[:wid])

    respond_to do |format|
      if @report.save
        @workflow.report=@report
        format.json { render :json => @report, :status => :created }
      else
        format.json { render :json => @report.errors, :status => 422 }
      end
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def getflow
    @workflow = Workflow.find(params[:workflow_id])
    if @workflow.customer_workflow
      @customer = @workflow.customer_workflow.customer
    else
      @customer = nil
    end
    if @workflow.vehicle_workflowship
      @vehicle = @workflow.vehicle_workflowship.vehicle
    else
      @vehicle = nil
    end
    if @workflow.fault_workflowship
      @faults = @workflow.fault_workflowship.faults
    else
      @faults = nil
    end
    respond_to do |format|
      format.html
    end
  end


  private

  def sort_column
    Report.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end