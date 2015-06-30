#coding: utf-8
class FaultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  # GET /faults
  # GET /faults.json
  layout "user"

  def index
    @faults = Fault.search(params[:faults]).paginate(:page => params[:page],  :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @faults }
    end
  end

  def fault_flow
    @faults = Fault.paginate(:page =>  params[:page],  :per_page =>  5)
    @workflow_fault = @current_company.workflows.where(:status => "fault")
    @warehouses = current_company.warehouses
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

  # GET /faults/1
  # GET /faults/1.json
  def show
    @fault = Fault.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @fault }
    end
  end

  # GET /faults/new
  # GET /faults/new.json
  def new
    @fault = Fault.new
    @workflow = Workflow.find(params[:wid])
    # require add oldparts database
    @categories = current_company.warehouses
    #@names = Oldpart.all.map{|o| [o.name]}.uniq
    #@drawings = Oldpart.all.map{|o| [o.drawing]}.uniq

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @fault }
    end
  end

  # POST /faults
  # POST /faults.json
  def create
    params[:fault][:status] = "0"
    @fault = Fault.new(params[:fault])
    @workflow = Workflow.find(params[:wid])
    if params[:add_continue]
      respond_to do |format|
        if @fault.save
          @workflow.faults << @fault
          if params[:oldpart]
            params[:oldpart][:pattern] = "直接"
            @oldpart = Oldpart.create(params[:oldpart])
            @fault.oldpart=@oldpart
            @workflow.oldparts << @oldpart
          end
          #format.html { redirect_to @fault, notice: 'Fault was successfully created.' }
          format.json { render :json => { :fault => @fault,
                                          :oldpart => @oldpart},
                                          :status => :created
                      }
        else
          #format.html { render action: "new" }
          format.json { render :json => @fault.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @fault.save
          @workflow.faults << @fault
          measure = @workflow.faults.map{|f| f.measure}.uniq
          if measure.include?('replace')
            params[:oldpart][:pattern] = "直接"
            @oldpart = Oldpart.create(params[:oldpart])
            @fault.oldpart = @oldpart
            @workflow.oldparts << @oldpart
            @workflow.update_attributes(:status => "newpart")
            #format.html { redirect_to @fault, notice: 'Fault was successfully created.' }
            format.json { render :json => { :fault => @fault,
                                          :oldpart => @oldpart},
                               :status => :created }
          else
            @workflow.update_attributes(:status => "report")
            format.json { render :json=> { :fault => @fault,
                                          :oldpart => @oldpart},
                               :status => :created }
          end
        else
          #format.html { render action: "new" }
          format.json { render :json => @fault.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # GET /faults/1/edit
  def edit
    @fault = Fault.find(params[:id])
    if @fault.oldpart
      @oldpart = @fault.oldpart
      respond_to do |format|
        format.json { render :json => {
            :fault => @fault,
            :oldpart => @oldpart
        }}
      end
    else
      respond_to do |format|
        format.json { render :json => @fault }
      end
    end
  end

  # PUT /faults/1
  # PUT /faults/1.json
  def update
    @fault = Fault.find(params[:id])
    if params[:oldpart]
      respond_to do |format|
        @oldpart = @fault.oldpart
        if @fault.update_attributes(params[:fault])
          @oldpart.update_attributes(params[:oldpart])
          format.json { head :ok}
        else
          format.json { render :json => @fault.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @fault.update_attributes(params[:fault])
          #format.html { redirect_to @fault, notice: 'Fault was successfully updated.' }
          format.json { head :ok }
        else
          #format.html { render action: "edit" }
          format.json { render :json => @fault.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /faults/1
  # DELETE /faults/1.json
  def destroy
    @fault = Fault.find(params[:id])
    @fault.destroy

    respond_to do |format|
      #format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def ind_fault_create
    puts "########### ind fault create begin ###########"
    @fault = Fault.find(params[:fault_id])
    @indfault = Indfault.new(params[:ind_fault])
    puts "########### Indfault new #############"
    if @indfault.save
      @fault.indfaults << @indfault
      puts "############ Indfault save ##################"
      if params[:ind_oldpart]
        params[:ind_oldpart][:ind_pattern] = "间接"
        @indirectpart = Indirectpart.create(params[:ind_oldpart])
        @indfault.indirectpart=@indirectpart
      end
      respond_to do |format|
        format.html {render :nothing => true}
        format.json { render :json => @indfault, :status => :created }
      end
    else
      respond_to do |format|
        format.html{render :nothing => true}
        format.json { render :json => @indfault.errors, :status => 422 }
      end
    end
  end

  def ind_fault_edit
    #@fault = Fault.find(params[:fault_id])
    puts "######{params[:ind_fault_id]}#######"
    @indfault = Indfault.find(params[:ind_fault_id])
    if @indfault.indirectpart.nil?
      respond_to do |format|
        format.json { render :json => @indfault }
      end
    else
      @indirectpart = @indfault.indirectpart
      respond_to do |format|
        format.json { render :json => {
            :indfault => @indsfault,
            :indirectpart => @indirectpart
          }
        }
      end
    end
  end

  def ind_fault_update
    @ind_fault = Indfault.find(params[:ind_fault_id])
    if @ind_fault.indirectpart.nil?
    else
      indirectpart = @ind_fault.indirectpart
    end
    respond_to do |format|
      if @ind_fault.update_attributes(params[:ind_fualt])
        if params[:indirectpart]
          indirectpart.update_attributes(params[:indirectpart])
        end
        format.json { head :ok }
      else
        format.json { render :json => @ind_fault.errors, :status => 422 }
      end
    end

  end

  def ind_fault_destroy
    @indfault = Indfault.find(params[:ind_id])
    if @indfault.destroy
      redirect_to "/faults/new?wid=#{@indfault.fault_indfaultship.fault.fault_workflowship.workflow_id}"
    end
  end

  def finished
    workflow = Workflow.find(params[:wid])
    measure = workflow.faults.map{|f| f.measure}.uniq
    respond_to do |format|
      if measure.include?('更换')
        workflow.update_attributes(:status => "newpart")
        #format.html { redirect_to @fault, notice: 'Fault was successfully created.' }
        format.json { head :ok }
      else
        workflow.update_attributes(:status => "report")
        format.json { head :ok }
      end
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
end
