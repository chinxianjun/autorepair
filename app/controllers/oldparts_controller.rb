#coding: utf-8
class OldpartsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company

  layout "user", :except => [:index]

  def index
    if params[:@category]
      @warehouse = Warehouse.where(:name => params[:@category]).first
      current_oldparts = Oldpart.where(:category => params[:@category])
    elsif params[:warehouse_id]
      @warehouse = Warehouse.find(params[:warehouse_id])
      current_oldparts = @warehouse.oldparts
    end
    @company = @current_company

    #@drawing_uniq = Oldpart.select(:drawing).uniq
    arr_oldparts = []
    current_oldparts.each do |ops|
      arr_oldparts << ops
      if arr_oldparts.size >= 2
        if arr_oldparts[-1].drawing === arr_oldparts[-2].drawing
          arr_oldparts.delete_at(-2)
        end
      end
    end

    @oldparts = arr_oldparts.paginate(:page=> params[:page], :per_page=> 10)

    @sum = 0
    @overflow = 0
    @stockout = 0

    current_oldparts.each do |o|
      @sum += o.price
    end

    respond_to do |format|
      format.json {render :json => @oldparts}
      format.html
    end

  end

  def oldpart_flow
    @oldparts = Oldpart.all
    @indirectparts = Indirectpart.all
    @workflow_oldpart = @current_company.workflows.where(:status => "oldpart")
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
  # GET /oldparts/1
  # GET /oldparts/1.json
  def show
    @oldpart = Oldpart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @oldpart }
    end
  end

  # GET /oldparts/new
  # GET /oldparts/new.json
  def new
    @oldpart = Oldpart.new

    @category = current_company.warehouses.where(:category => "旧件")
    if params[:wid]
      @workflow = Workflow.find(params[:wid])
      @fault = Fault.find(params[:fault_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=>@oldpart }
    end
  end


  # POST /oldparts
  # POST /oldparts.json
  def create
    warehouse = Warehouse.find(params[:warehouse_id])

    #根据旧件数量创建旧件
    params[:count].to_i.times{
      @oldpart = Oldpart.new(params[:oldpart])

      if params[:wid]
        @workflow = Workflow.find(params[:wid])
        @fault = Fault.find(params[:fault_id])
        if @oldpart.save
            @oldpart.fault = @fault
            @workflow.oldparts << @oldpart
            warehouse.oldparts << @oldpart
            @workflow.update_attributes(:oldparter => current_user.fullname)
            if @workflow.faults.last === @fault
              @workflow.update_attributes(:status => "newpart")
            end
            @oldpart.update_attributes(:oldpart_manager => current_user.fullname)
        end
      else
        if @oldpart.save
          warehouse.oldparts << @oldpart
        end
      end
    }
    respond_to do |format|
      if @oldpart.save
        #format.html { redirect_to @oldpart, notice: 'Oldpart was successfully created.' }
        format.json { render :json=> @oldpart, :status=> :created }
      else
        #format.html { render action: "new" }
        format.json { render :json=> @oldpart.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # GET /oldparts/1/edit
  def edit
    @oldpart = Oldpart.find(params[:id])

    @category = current_company.parts.where(:category => "旧件")
    respond_to do |format|
      format.html
      format.json { render :json => @oldpart }
    end
  end

  # PUT /oldparts/1
  # PUT /oldparts/1.json
  def update
    @oldpart = Oldpart.find(params[:id])

    respond_to do |format|
      if @oldpart.update_attributes(params[:oldpart])
        #format.html { redirect_to @oldpart, notice: 'Oldpart was successfully updated.' }
        format.json { head :ok }
      else
        #format.html { render action: "edit" }
        format.json { render :json=> @oldpart.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /oldparts/1
  # DELETE /oldparts/1.json
  def destroy
    @oldpart = Oldpart.find(params[:id])
    @oldpart.destroy

    respond_to do |format|
      #format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def ind_index
    @indirectpart = Indirectpart.paginate(:page=>  params[:page],  :per_page=> 5)

    respond_to do |format|
      #format.html
      format.json { render :json => @indirectpart }
    end
  end

  def ind_new
    @indirectpart = Indirectpart.new
    @oldpart = Oldpart.find(params[:oldpart_id])
    @workflow = Workflow.find(params[:wid])
    respond_to do |format|
      #format.html
      format.json { render :json => @indirectpart }
    end
  end

  def ind_create
    @indirectpart = Indirectpart.new(params[:indirectpart])
    @oldpart = Oldpart.find(params[:direct_id])
    @workflow = Workflow.find(params[:wid])
    @workflow.update_attributes(:oldparter => current_user.fullname)
    @fault = Fault.find(params[:fault_id])
    respond_to do |format|
      if @indirectpart.save
        @oldpart.indirectparts << @indirectpart
        @workflow.indirectparts << @indirectpart
        @fault.indirectpart = @indirectpart
        @workflow.update_attributes(:status => "newpart")
        @indirectpart.update_attributes(:oldpart_manager => current_user.fullname)
        format.json { render  :json => @indirectpart, :status => :created }
      else
        format.json { render :json => @indirectpart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def ind_show
    @indirectpart = Indirectpart.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @indirectpart }
    end
  end

  def ind_edit
    @indirectpart = Indirectpart.find(params[:id])

    respond_to do |format|
      format.json { render :json => @indirectpart }
    end
  end

  def ind_update
    @indirectpart = Indirectpart.find(params[:id])

    respond_to do |format|
      if @indirectpart.update_attributes(params[:indirectpart])
        format.json { head  :ok }
      else
        format.json { render :json => @indirectpart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def ind_destroy
    @indirectpart = Indirectpart.find(params[:id])
    @indirectpart.destroy

    respond_to do |format|
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def oldpart_search
    key_word = params[:q]
    @oldparts =Oldpart.connection.select_values("select name from oldparts where name like '%#{key_word}%'")
    respond_to do |format|
      format.html { render :text => @oldparts.join("\n")}
      format.json { render :json => {:oldparts => @oldparts.as_json(:only =>[:name])}}
    end
  end

  def oldpart_out
    @oldpart = Oldpart.find(params[:id])
  end
end
