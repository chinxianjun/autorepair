#coding: utf-8
class NewpartsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  # GET /newparts
  # GET /newparts.json
  layout "user"

  def index
    #if params[:category]
    #  @names = Part.where(:category=>"新件").map{|n| [n.name]}.uniq
    #  respond_to do |format|
    #    format.json { render :json=> @names }
    #  end
    #elsif params[:name]
    #  @drawings = Newpart.where(:name => params[:name]).map{|d| [d.drawing]}.uniq
    #  @prices = Newpart.where(:name => params[:name]).map{|p| [p.price]}.uniq
    #
    #  respond_to do |format|
    #    format.json {
    #      render :json=> {
    #                      :drawings => @drawings,
    #                      :prices => @prices
    #                    }
    #    }
    #  end
    #else
      @newparts = Newpart.paginate(:page=>  params[:page],  :per_page=> 10)
      @category = current_company.warehouses

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json=> @newparts }
      end
    #end
  end

  def newpart_flow
    @newparts = Newpart.paginate(:page=>  params[:page],  :per_page=> 10)
    @workflow_newpart = @current_company.workflows.where(:status => "newpart")
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

  # GET /newparts/1
  # GET /newparts/1.json
  def show
    @newpart = Newpart.find(params[:id])
    #@workflow = Workflow.find(params[:wid])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @newpart }
    end
  end

  # 确认新件
  def receive
    @workflow = Workflow.find(params[:wid])
    @category = current_company.warehouses
    @fault = @workflow.faults

    respond_to do |format|
      format.html
    end
  end

  def receive_finish
    @workflow = Workflow.find(params[:wid])
    @warehouse = current_company.warehouses.where(:name => params[:newpart][:category]).first
    #current_newparts = @warehouse.newparts
    @newparts = Newpart.where(:drawing => params[:newpart][:drawing])  # 获取输入的图号相匹配的配件

    untreatedFaultCount = @workflow.faults.where(:status => "1")

    if (params[:newpart][:count].to_i <= @newparts.size)
      respond_to do |format|
        if @workflow.update_attributes(:status => "report", :newparter => current_user.fullname)
          newparts = @newparts.to_a.sample(params[:newpart][:count].to_i)
          newparts.each do |n|
            n.update_attributes(:status => "出库")
          end

          @workflow.newparts = newparts
          if @workflow.users.any?
            @workflow.users.each do |user|
              user.update_attributes(:status => "")
            end
          end
          format.json { head :ok }
        else
          format.json { render :json => @workflow.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => @newparts, :status => 416 }
      end
    end
  end

  # GET /newparts/new
  # GET /newparts/new.json
  def new
    @newpart = Newpart.new
    @category = current_company.warehouses.where(:category => "新件")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @newpart }
    end
  end

  # POST /newparts
  # POST /newparts.json
  def create
    params[:newpart][:count].to_i.times{

      @newpart = Newpart.new(params[:newpart])
      @newpart.save
    }
    respond_to do |format|
      if @newpart.save
        #format.html { redirect_to @newpart, notice: 'Newpart was successfully created.' }
        format.json { render :json=> @newpart, :status=> :created }
      else
        #format.html { render action: "new" }
        format.json { render :json=> @newpart.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # GET /newparts/1/edit
  def edit
    @newpart = Newpart.find(params[:id])
    @category = current_company.parts.where(:category => "新件")
    #@workflow = Workflow.find(params[:wid])
    #@fault = Fault.find(params[:fault_id])
    respond_to do |format|
      format.json { render :json => @newpart }
    end
  end

  # PUT /newparts/1
  # PUT /newparts/1.json
  def update
    @newpart = Newpart.find(params[:id])

    if params[:status] == 'ok'
      @workflow = Workflow.find(params[:wid])
      @workflow.update_attributes(:status => "report", :newparter => current_user.fullname)
      respond_to do |format|
        format.html { redirect_to workflow_flow_workflows_path }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        if @newpart.update_attributes(params[:newpart])
          #format.html { redirect_to @newpart, notice: 'Newpart was successfully updated.' }
          format.json { head :ok }
        else
          #format.html { render action: "edit" }
          format.json { render :json=> @newpart.errors, :status=> :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /newparts/1
  # DELETE /newparts/1.json
  def destroy
    @newpart = Newpart.find(params[:id])
    @newpart.destroy

    respond_to do |format|
      format.html { redirect_to newparts_url }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  # 新旧件校对
  def contrast_index
    @newparts = Newpart.all
    @old_newships = OldpartNewpartship.all
    @oldparts = Oldpart.all
    respond_to do |format|
      format.html
      format.json { render :json => {
          :old_newships => @old_newships
          #:oldparts => @oldparts,
          #:newparts => @newparts
        }
      }
    end
  end

  def contrast_show
    @newpart = Newpart.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @contrast }
    end
  end

  def contrast_new
    @newpart = Newpart.new
    @oldpart = Oldpart.new

    respond_to do |format|
      format.json { render :json =>
                     {
                        :newpart => @newpart,
                        :oldpart => @oldpart
                     }
      }
    end
  end

  def contrast_create
    if params[:contrast] == "oldpart"
      if Oldpart.where(:drawing => params[:oldpart][:drawing]).size > 0
        @oldpart = Oldpart.where(:drawing => params[:oldpart][:drawing]).first
      else
        @oldpart = Oldpart.new(params[:oldpart])
        @oldpart.save
      end
    elsif params[:contrast] == "newpart"
      if Newpart.where(:drawing => params[:newpart][:drawing]).size > 0
        @newpart = Newpart.where(:drawing => params[:newpart][:drawing]).first
      else
        @newpart = Newpart.new(params[:newpart])
      end
      @oldpart = Oldpart.find(params[:oldpart_id])
      @oldpart.newparts << @newpart
    end



    respond_to do |format|
      format.json { render :json => @oldpart, :status => :created }
    end
  end

  def contrast_edit
    @contrast = Contrast.find(params[:id])

    respond_to do |format|
      format.json { render :json => @contrast }
    end
  end

  def contrast_update
    @contrast = Contrast.find(params[:id])

    respond_to do |format|
      if @contrast.update_attributes(params[:contrast])
        format.json { head :ok }
      else
        format.json { render :json => @contrast.errors, :status => :unprocessable_entity }
      end
    end
  end

  def contrast_destroy
    @contrast = Contrast.find(params[:id])
    @contrast.destroy

    respond_to do |format|
      format.html
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def newpart_search
    key_word = params[:q]
    @newparts =Newpart.connection.select_values("select name from newparts where name like '%#{key_word}%'")
    respond_to do |format|
      format.html { render :text => @newparts.join("\n")}
      format.json { render :json => {:newparts => @newparts.as_json(:only =>[:name])}}
    end
  end
end
