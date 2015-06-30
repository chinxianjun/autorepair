#coding: utf-8
class VehiclesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  helper_method :sort_column, :sort_direction

  layout "user"

  def index
    #@search = Vehicle.search(params[:search])
    @vehicles = Vehicle.search(params[:vehicle]).order(sort_column + " " + sort_direction).paginate(:page =>  params[:page],  :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render :json => @vehicles }
    end
  end

  def vehicle_flow
    @vehicles = Vehicle.paginate(:page=>  params[:page],  :per_page=> 10)
    @workflow_vehicle = @current_company.workflows.where(:status => "vehicle")
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

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    @vehicle = Vehicle.find(params[:id])
    @owner = @vehicle.owner
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @vehicle }
    end
  end

  # GET /vehicles/new
  # GET /vehicles/new.json
  def new
    if params[:wid]
      @workflow = Workflow.find(params[:wid])
      @customer = @workflow.customer_workflow.customer
      #@car_number = @workflow.faultdesc.car_number
      #vehicles = @workflow.where(:car_number => @car_number).size > 0
      car = @workflow.vehicle_workflowship.vehicle
      if car
        @vehicle = car
        @owner = @vehicle.owner
      else
        @vehicle = Vehicle.new
        @owner = Owner.new
      end
    else
      @vehicle = Vehicle.new
      @owner = Owner.new
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @vehicle }
    end
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    vehicles = Vehicle.where(:engine_number => params[:vehicle][:engine_number]).size > 0
    if params[:wid]
      @workflow = Workflow.find(params[:wid])
      if Owner.where(:fullname => params[:owner][:fullname], :phone => params[:owner][:phone]).size > 0
        @owner = vehicles.last.owner
      else
        @owner = Owner.new(params[:owner])
      end
      if vehicles
        @vehicle = vehicles.last
        respond_to do |format|
            @vehicle.owner = @owner
            @vehicle.workflows << @workflow
            @workflow.update_attributes(:status => "fault")
            #format.html {redirect_to :action=>"new", :alert => "该车辆信息已存在"}
            format.json { render :json => @vehicle, :status => :created }
        end
      else
        @vehicle = Vehicle.new(params[:vehicle])

        respond_to do |format|
          if @vehicle.save
            @vehicle.owner = @owner
            @vehicle.workflows << @workflow
            @workflow.update_attributes(:status => "fault")
            #format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
            format.json { render :json => @vehicle, :status => :created }
          else
            #format.html { render action: "new" }
            format.json { render :json => @vehicle.errors, :status => :unprocessable_entity }
          end
        end
      end
    else
      if Owner.where(:fullname => params[:owner][:fullname], :phone => params[:owner][:phone]).size > 0

      else
        @owner = Owner.new(params[:owner])
      end
      if vehicles
        respond_to do |format|
          format.html {redirect_to :action=>"new", :notice => "该车辆信息已存在"}
          #format.json
        end
      else
        @vehicle = Vehicle.new(params[:vehicle])
        respond_to do |format|
          if @vehicle.save
             @owner.save
             @vehicle.owner=@owner
              format.json { render :json => @vehicle, :status => :created }
          else
            format.json { render :json => @vehicle.errors, :status => :unprocessable_entity }
          end
        end
      end
    end
  end

  # GET /vehicles/1/edit
  def edit
    if params[:wid]
      @workflow = Workflow.find(params[:wid])
      @vehicle = @workflow.vehicle_workflowship.vehicle

    else
      @vehicle = Vehicle.find(params[:id])
    end
    @owner = @vehicle.owner
    respond_to do |format|
      format.json { render :json => @vehicle }
      format.html
    end
  end

  # PUT /vehicles/1
  # PUT /vehicles/1.json
  def update
    @vehicle = Vehicle.find(params[:id])
    @workflow = Workflow.find(params[:wid])
    if @vehicle.owner.nil?
      @owner = Owner.new
    else
      @owner = @vehicle.owner
    end
    respond_to do |format|
      if @vehicle.update_attributes(params[:vehicle])
        if @owner
          @owner.update_attributes(params[:owner])
          @workflow.update_attributes(:status => "fault") unless params[:wid].nil?
        else
          @owner = Owner.new(params[:owner])
          if @owner.save
            @vehicle.owner=@owner
            @workflow.update_attributes(:status => "fault") unless params[:wid].nil?
            #format.json { head :ok }
          else
            #format.json {render :json => @owner.errors, :status=>422}
          end
        end

        format.html { redirect_to :back }
        format.json { head :ok }
      else
        #format.html { render action: "edit" }
        format.json { render :json => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy

    respond_to do |format|
      #format.html { redirect_to customers_index_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def vehicle_workflows
    @vehicle = Vehicle.find(:id)
    @workflows = @vehicle.workflows
    respond_to do |format|
      format.html
    end
  end

  def owner_index
    @owners = Owner.all
    respond_to do |format|
      format.html
      format.json { render :json => @owners }
    end
  end

  def owner_new
    @vehicle = Vehicle.find(params[:id])
    @owner = Owner.new
    respond_to do |format|
      format.json { render :json => @owner }
    end
  end

  def owner_create
    @vehicle = Vehicle.find(params[:id])
    @owner = Owner.new(params[:owner])
    respond_to do |format|
      if @owner.save
        @vehicle.owner = @owner
        @vehicle.update_attributes(:workplace => params[:owner][:workplace])
        format.json { render :json => @customer, :status => :created }
      else
        format.json { render :json => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def owner_edit
    @vehicle = Vehicle.find(params[:id])

    @owner = @vehicle.owner
    respond_to do |format|
      format.json { render :json => @owner }
    end
  end

  def owner_update
    @vehicle = Vehicle.find(params[:id])
    @owner = @vehicle.owner

    respond_to do |format|
      if @owner.update_attributes(params[:owner])
        @vehicle.update_attributes(:workplace => params[:owner][:workplace])
        #format.html { redirect_to customers_path, notice: 'Customer was successfully updated.' }
        format.json { head :ok }
      else

        #format.html { render action: "edit" }
        format.json { render :json => @owner.errors, :status => :unprocessable_entity }
      end
    end

  end

  def owner_show
    @vehicle = Vehicle.find(params[:id])

    @owner = @vehicle.owner
    respond_to do |format|
      format.html
      format.json { render :json => @owner }
    end
  end

  def owner_destroy

  end

  private

  def sort_column
    Vehicle.column_names.include?(params[:sort]) ? params[:sort] : "model"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
