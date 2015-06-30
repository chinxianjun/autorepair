class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize, :except => [:search, :history]
  before_filter :current_company
  #helper_method :sort_column, :sort_direction
  layout "user"

  #message string
  #http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=ZXHD-SDK-0108-EBQNKI&pwd=ece0ea2c5ec194b46dc88b29c5a07ffb&phone=18226020788&CONTENT=%ba%a3%cc%a9%c6%fb%d0%de%d7%a3%c4%fa%b9%a4%d7%f7%d3%e4%bf%ec%a1%a3&extnum=1&level=1&schtime=null&reportflag=0&url=&smstype=0&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

  def index
    @messages = Message.search(params[:messages]).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.json { render :json => @messages }
    end
  end

  def show
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @message }
    end
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.html
      format.json { render :json => @message }
    end
  end

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save
        #format.html
        format.json { render :json => @message, :status => :created }
      else
        format.html { render :action => "new" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @message = Message.find(params[:id])
    respond_to do |format|
#      format.html
      format.json { render :json => @message }
    end
  end

  def update
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.update_attributes(params[:message])
        #format.html
        format.json { head :ok }
      else
        format.html
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_index_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def account
    #@messages = Message.all
    respond_to do |format|
      format.html
    end
  end

  def history
    @histories = History.search(params[:search]).paginate(page: params[:page], per_page: 10).order("created_at DESC")

    if request.post?
      @history = History.new(params[:history])
      respond_to do |format|
        if @history.save
          format.json { render :json => @history, :status => :created }
        else
          format.json { render :json => @history.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def send_msg
    params[:phone] ? @phone = params[:phone] : @phone = nil
    params[:name] ? @name= params[:name] : @name = nil
    @messages = Message.all

    respond_to do |format|
      format.html
    end
  end

  def multi_send_msg
    @groups = current_company.groups.includes(:users)
    @customers = Customer.all
    @categories = Category.all
    @messages = Message.all
    respond_to do |format|
      format.html
    end
  end


  def customer_message
    @categories = Category.all
  end

  def company_message
    @groups = current_company.groups.includes(:users)
  end

  def multi_messages
    puts "########00000000##########"
    @people = []
    @categories = Category.all
    @messages = Message.all
    puts "########################"
    if params[:category_ids]
      puts params[:category_ids]
      cids= params[:category_ids].split(",").map { |s| s.to_i }
      category = Category.find(cids)
      puts "####"
      puts category
      puts "####"
      category.each do |cate|
        @people << Customer.where(:category => cate.category)
      end
    elsif params[:group_ids]
      puts params[:group_ids]
      gids = params[:group_ids].split(",").map { |s| s.to_i }
      group = Group.find(gids)
      puts "####"
      puts group
      puts "####"
      group.each do |g|
        @people << g.users
      end
    end
    @people = @people.flatten.uniq
    respond_to do |format|
      format.html
    end

    #@people = @people.uniq!

  end
end
