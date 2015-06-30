#coding: utf-8
class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company
  layout "user"

  def index
    #@questions = Question.includes(:customer).order("created DESC").paginate(page: params[:page], per_page: 10)
    if Question.where(:processor => current_user.fullname).any?
      @repair_question = Question.where(:category => "repair", :processor => current_user.fullname).paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    elsif Question.where(:salesman => current_user.fullname).any?
      @repair_question = Question.where(:category => "repair", :salesman => current_user.fullname).paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    else
      @repair_question = Question.where(:category => "repair").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    end

    respond_to do |format|
      format.html
      format.json { render :json => @repair_question }
    end
  end

  def show
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @question }
    end
  end

  def managers
    if params[:manager]

      case (params[:manager])
        when "维修"
          if current_company.groups.where(:name => "维修经理").any?
            @managers = current_company.groups.where(:name => "维修经理").first.users
          end
        when "购车"
          if current_company.groups.where(:name => "销售经理").any?
            @managers = current_company.groups.where(:name => "销售经理").first.users
          end
        when "购件"
          if current_company.groups.where(:name => "购件经理").any?
            @managers = current_company.groups.where(:name => "购件经理").first.users
          end
        when "咨询"
          if current_company.groups.where(:name => "客服经理").any?
            @managers = current_company.groups.where(:name => "客服经理").first.users
          end
        when "投诉"
          if current_company.groups.where(:name => "客服经理").any?
            @managers = current_company.groups.where(:name => "客服经理").first.users
          end
        else
          @managers = []
      end
      respond_to do |format|
        format.json { render :json => {:managers => @managers}}
      end
    end
  end

  def new
    @question = Question.new
    @customer = Customer.find(params[:customer_id])

    if params[:manager]
      case (params[:manager])
        when "维修"
          if current_company.groups.where(:name => "维修经理").any?
            @managers = current_company.groups.where(:name => "维修经理").first.users
          end
        when "购车"
          if current_company.groups.where(:name => "销售经理").any?
            @managers = current_company.groups.where(:name => "销售经理").first.users
          end
        when "购件"
          if current_company.groups.where(:name => "购件经理").any?
            @managers = current_company.groups.where(:name => "购件经理").first.users
          end
        when "咨询"
          if current_company.groups.where(:name => "客服经理").any?
            @managers = current_company.groups.where(:name => "客服经理").first.users
          end
        when "投诉"
          if current_company.groups.where(:name => "客服经理").any?
            @managers = current_company.groups.where(:name => "客服经理").first.users
          end
        else
          @managers = []
      end
      respond_to do |format|
        format.html
        format.json { render :json => {:managers => @managers, :question => @question}}
      end
    else
      @managers = current_company.groups.where(:name => "维修经理").first.users
      respond_to do |format|
        format.html
        format.json { render :json => @question }
      end
    end
  end

  def create
    params[:question][:creator] = current_user.fullname
    if params[:manager]
      @manager = User.where(:fullname => params[:manager]).first
      params[:question][:processor] = params[:manager]
    end

    @question = Question.new(params[:question])
    # created message history
    if params[:history]
      history = History.new(params[:history])
      history.save
    end

    customer = Customer.find(params[:customer_id])
    if params[:faultdesc] # create repair question
      faultdesc = Faultdesc.create(params[:faultdesc])

      workflow = Workflow.create(:creator => current_user.fullname,
                                :warranty => params[:faultdesc][:warranty],
                                 :status => 'dispatch')
      vehicle = Vehicle.where(:chassis_number => params[:vehicle][:chassis_number]).first
      if vehicle
        new_vehicle = vehicle.update_attirbutes(params[:vehicle])
      else
        new_vehicle = Vehicle.new(params[:vehicle])
        new_vehicle.save
      end
      respond_to do |format|
        if @question.save
          customer.questions << @question
          new_vehicle.workflows << workflow
          workflow.faultdesc = faultdesc
          customer.workflows << workflow
          @current_company.workflows << workflow
          # create dispatching(no have dispatching info)
          dispatching = Dispatching.create(:property => params[:faultdesc][:warranty])
          workflow.dispatching = dispatching
          format.json { render :json => @question, :status => :created }
          #format.json { redirect_to = "/messages/send_msg?phone=#{customer.phone}" }
        else
          format.html { render :action => 'new' }
        end
      end
    else
      respond_to do |format|
        if @question.save
          customer.questions << @question
          # created buy car question
          if params[:question][:category] == "buy_car"
            if params[:manager]
              buy_car = CarBuying.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:manager],
                                      :referral => params[:referral],
                                      :status => "指派业务员")
            else
              buy_car = CarBuying.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:question][:processor],
                                      :referral => params[:referral],
                                      :status => "指派业务员")
            end
            if buy_car.save
              @question.car_buyings << buy_car
            end
          # created buy part question
          elsif params[:question][:category] == "buy_part"
            if params[:manager]
              buy_part = PartBuying.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:manager],
                                      :status => "未处理")
            else
              buy_part = PartBuying.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:question][:processor],
                                      :status => "未处理")
            end
            if buy_part.save
              @question.part_buyings << buy_part
            end
          # created complaint question
          elsif params[:question][:category] == "complaint"
            if params[:manager]
              comp = Complaint.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:manager],
                                      :category => "一般",
                                      :status => "未处理")
            else
              comp = Complaint.new(:creator => current_user.fullname,
                                      :description => params[:question][:description],
                                      :manager => params[:question][:processor],
                                      :category => "一般",
                                      :status => "未处理")
            end

            if comp.save
              @question.complaints << comp
            end
          # created consulting question
          elsif params[:question][:category] == "consulting"
            if params[:manager]
              cons = Consulting.new(:creator => current_user.fullname,
                                      :question => params[:question][:description],
                                      :answerer => params[:manager],
                                      :status => "未处理")
            else
              cons = Consulting.new(:creator => current_user.fullname,
                                      :question => params[:question][:description],
                                      :answerer => params[:question][:processor],
                                      :status => "未处理")
            end
            if cons.save
              @question.consultings << cons
            end
          end
          format.json { render :json => @question, :status => :created }
          if params[:manager]
            if params[:question][:category] == "repair"
              #format.html
              format.json { render :json => @question, :status => :created}
              #format.json { redirect_to  "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=#{account}
              #            &pwd=#{password}&phone=#{@manager.phone}&CONTENT=#{params[:faultdesc]}
              #            &extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0
                          #&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
            elsif params[:question][:category] == "buy_car"
              #format.html
              format.json { render :json => @question, :status => :created}
              #format.json { redirect_to "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=#{account}
              #              &pwd=#{password}&phone=#{@manager.phone}&CONTENT=#{params[:description]}
              #              &extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0
              #              &key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
            elsif params[:question][:category] == "buy_part"
              #format.html
              format.json { render :json => @question, :status => :created}
              #format.json { redirect_to "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=#{account}
              #              &pwd=#{password}&phone=#{@manager.phone}&CONTENT=#{params[:description]}
              #              &extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0
              #              &key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
            elsif params[:question][:category] == "consulting"
            #  format.json { render :json => @question, :status => :created}
              #format.json { redirect_to "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=#{account}
              #              &pwd=#{password}&phone=#{@manager.phone}&CONTENT=#{params[:description]}
              #              &extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0
              #              &key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
            elsif params[:question][:category] == "complaint"
              format.json { render :json => @question, :status => :created}
              #format.html
              #format.json { redirect_to "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=#{account}
              #              &pwd=#{password}&phone=#{@manager.phone}&CONTENT=#{params[:description]}
              #              &extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0
              #              &key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
            end
          end
        else
          #format.html {render :back}
          format.json { render :json => @questions.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def repair
    #if Question.where(:processor => current_user.fullname).any?
      @repair_question = Question.where(:category => "repair").paginate(:page=> params[:page], :per_page => 10).order("created_at DESC")
    #end
    respond_to do |format|
      format.html
    end
  end

  def repair_new
    @customer = Customer.find(params[:customer_id])

    if current_company.groups.where(:name => "维修经理")
      @managers = current_company.groups.where(:name => "维修经理").first.users
    else
      @managers = nil
    end
  end

  def buy_car
    if current_user.groups.where(:name  => "销售经理").any?
      @buy_car_question = Question.where(:category => "buy_car", :processor => current_user.fullname).paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    elsif current_user.groups.where(:name  => "业务员").any?
      @buy_car_question = Question.includes(:car_buyings).order("car_buyings.created_at DESC").where(:car_buyings => {:salesman => current_user.fullname}).paginate(:page=> params[:page], :per_page=> 10)
    elsif current_user.groups.where(:name => "客服").any?
      @buy_car_question = Question.where(:category => "buy_car", :status => "未处理").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    else
      @buy_car_question = Question.where(:category => "buy_car").paginate(:page=> params[:page], :per_page=> 10)
    end
    respond_to do |format|
      format.html
    end
  end

  def buy_car_new
    @customer = Customer.find(params[:customer_id])
    if current_company.groups.where(:name => "销售经理").size > 0
      @managers = current_company.groups.where(:name => "销售经理").first.users
    else
      @managers =nil
    end
  end

  def buy_part
    if Question.where(:processor => current_user.fullname).any?
      @buy_part_question = Question.where(:category => "buy_part", :processor => current_user.fullname).paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    elsif Question.where(:salesman => current_user.fullname).any?
      @buy_part_question = Question.where(:category => "buy_part", :salesman => current_user.fullname).paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    elsif current_user.groups.where(:name => "客服").any?
      @buy_car_question = Question.where(:category =>"buy_part", :status => "未处理").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    else
      @buy_part_question = Question.where(:category => "buy_part").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    end
    respond_to do |format|
      format.html
    end
  end

  def buy_part_new
    @customer = Customer.find(params[:customer_id])
    if current_company.groups.where(:name => "配件经理").size > 0
      @managers = current_company.groups.where(:name => "配件经理").first.users
    else
      @managers = nil
    end
  end

  def consulting
    if Question.where(:processor => current_user.fullname).any?
      @consulting_question = Question.includes(:consultings).order("consultings.created_at DESC").where(:consultings => {:answerer => current_user.fullname}).paginate(:page=> params[:page], :per_page=> 10)
    elsif current_user.groups.where(:name => "客服").any?
      @buy_car_question = Question.where(:category => "consulting", :status => "未处理").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    else
      @consulting_question = Question.where(:category => "consulting").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    end
    respond_to do |format|
      format.html
    end
  end

  def consulting_new
    @customer = Customer.find(params[:customer_id])

    if current_company.groups.where(:name => "客服").size > 0
      @managers = current_company.groups.where(:name => "客服").first.users
    else
      @managers = nil?
    end

    respond_to do |format|
      format.html
    end

  end

  def complaint
    if Question.where(:processor => current_user.fullname).any?
      @complaint_question = Question.includes(:complaints).order("complaints.created_at DESC").where(:complaints => {:manager => current_user.fullname}).paginate(:page=> params[:page], :per_page=> 10)
    elsif current_user.groups.where(:name => "客服").any?
      @buy_car_question = Question.where(:category => "complaint", :status => "未处理").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    else
      @complaint_question = Question.where(:category => "complaint").paginate(:page=> params[:page], :per_page=> 10).order("created_at DESC")
    end
    respond_to do |format|
      format.html
    end
  end

  def complaint_new
    @customer = Customer.find(params[:customer_id])

    if current_company.groups.where(:name => "客服").size > 0
      @managers = current_company.groups.where(:name => "客服").first.users
    else
      @managers = nil
    end
  end

  def search_vehicle
    key_word = params[:q]
    @vehicles =Vehicle.connection.select_values("select chassis_number from vehicles where chassis_number like '%#{key_word}%'")
    respond_to do |format|
      #format.html
      format.json { render :json => {:vehicles => @vehicles.as_json(:only =>[:name])}}
    end
  end
end
