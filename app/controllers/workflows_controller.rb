#coding: utf-8
class WorkflowsController < ApplicationController
  # GET /workflows
  # GET /workflows.json
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  layout "user"

  def index
    @workflows = Workflow.paginate(page:  params[:page],  per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workflows }
    end
  end

  def workflow_flow
    dispatch_count = 0
    vehicle_count = 0
    fault_count = 0
    oldpart_count = 0
    newpart_count = 0
    report_count = 0
    expense_count = 0
    @workflows = @current_company.workflows
    puts "###########################################"
    puts ">>>>current company: #{@current_company.workflows} <<<<"
    puts "###########################################"
    @workflows.each do |workflow|
      case workflow.status
        when "dispatch"
          #@my_dispatchings << workflow.dispatching unless workflow.dispatching.nil?
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
      format.html # index.html.erb
      format.json {
        render json:
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

  # GET /workflows/1
  # GET /workflows/1.json
  def show
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/new
  # GET /workflows/new.json
  def new
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @faultdesc = Faultdesc.create(
          :place => params[:fault_place],
          :car_number => params[:fault_car_number],
          :description => params[:fault_description]
      )
      @workflow = Workflow.create(
          :creator => params[:workflow_create],
          :status => 'dispatching'

      )
      respond_to do |format|
        if @workflow.save
          @customer.workflows << @workflow
          @workflow.faultdesc = @faultdesc
          current_company.workflows << @workflow
          format.json {
            render :json => {
                :workflow => @workflow,
                :faultdesc => @faultdesc,
                :customer => @customer
            }
          }
        else
          format.json {
            render :json => @workflow.errors, :status => 422
          }
        end
      end
    else
      @workflow = Workflow.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @workflow }
      end
    end
  end

  # GET /workflows/1/edit
  def edit
    @workflow = Workflow.find(params[:id])
    if params[:customer_name]
      @workflow.faultdesc.update_attributes(
          :place => params[:fault_place],
          :car_number => params[:fault_car_number],
          :description => params[:fault_description]
      )
      respond_to do |format|
        format.json { render :json => @workflow, :status => 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @workflow }
      end
    end
  end

  # POST /workflows
  # POST /workflows.json
  def create
    params[:workflow][:creator] = current_user.fullname
    @workflow = Workflow.new(params[:workflow])
    if Customer.where(:phone => params[:customer][:phone]).size > 0
       @customer = Customer.where(:phone => params[:customer][:phone]).last
    else
      # new customer
      @customer = Customer.new(params[:customer])
      @customer.save
    end
    @faultdesc = Faultdesc.new(params[:faultdesc])
    @faultdesc.save

    @customer.faultdescs << @faultdesc
    respond_to do |format|
      if @workflow.save
        # company has_many workflow through company_workflows
        @current_company.workflows << @workflow
        #
        @customer.workflows << @workflow
        @workflow.faultdesc = @faultdesc
        # create dispatching(no have dispatching info)
        dispatching = Dispatching.create

        @workflow.dispatching = dispatching
        #format.html { redirect_to @workflow, notice: 'Workflow was successfully created.' }
        format.json { render json: @workflow, status: :created }
      else
        #format.html { render action: "new" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workflows/1
  # PUT /workflows/1.json
  def update
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      if @workflow.update_attributes(params[:workflow])
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.json
  def destroy
    @workflow = Workflow.find(params[:id])
    @workflow.destroy

    respond_to do |format|
      format.html { redirect_to workflows_url }
      format.json { head :ok }
    end
  end

  def home

  end
end
