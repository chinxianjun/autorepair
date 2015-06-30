#coding: utf-8

class CustomersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize, :except => [:level]
  before_filter :current_company
  helper_method :sort_column, :sort_direction

  layout "user"

  def index
    #@search = Customer.all
    @customers = Customer.search(params[:column]).order(sort_column + " " + sort_direction).paginate(:page=> params[:page], :per_page=> 10)

    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render :json=> {:customers => @customers} }
      #format.xls to use export excel
      format.xls {
        send_data(xls_content_for(@search),
                :type => "text/excel;charset=utf-8; header=present",
                :filename => "Report_Customer_#{Time.now.strftime("%Y%m%d")}.xls")
      }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.includes(:faultdescs).find(params[:id])
    @faultdesc = @customer.faultdescs.last
    @categories = Category.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      #format.html # new.html.erb
      format.json { render :json=> @customer }
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.where(:fullname => params[:customer][:fullname], :phone => params[:customer][:phone]).first

    if @customer
      respond_to do |format|
        #format.html { redirect_to :back }
        format.json { render :json => @customer, :status => 200 }
      end
    else
      @customer = Customer.new(params[:customer])

      respond_to do |format|
        if @customer.save
          #format.html { redirect_to customers_path, notice: 'Customer was successfully created.' }
          format.json { render :json=> @customer, :status=> :created }
        else
          #format.html { render action: "new" }
          format.json { render :json=> @customer.errors, :status=> :unprocessable_entity }
        end
      end
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
    @categories = Category.all
    #@faultdesc = @customer.faultdescs.last
    respond_to do |format|
      #format.html
      format.json { render :json => @customer }
    end
  end


  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        #format.html { redirect_to customers_path }
        format.json { head :ok }
      else
        #format.html { render action: "edit" }
        format.json { render :json=> @customer.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      #format.html { redirect_to customers_index_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def search
    @customers = Customer.where('fullname LIKE ? OR phone LIKE ? OR category LIKE ?', "%#{params[:column]}%", "%#{params[:column]}%", "%#{params[:column]}%")

    respond_to do |format|
      #format.html
      format.json { render :json => {:customers => @customers} }
    end
  end

  def question
    @customer = Customer.find(params[:customer_id])
    respond_to do |format|
      format.html
      format.json { render :json => @customer }
    end
  end

  def category
    @categories = Category.search(params[:search]).paginate(:page=> params[:page], :per_page=> 10)
    if params[:id]
      @category =Category.find(params[:id])
    end

    respond_to do |format|
      if request.post?
        @category = Category.new(params[:category])
        @category.save
        format.json { render :json => @category }
        format.html { redirect_to request.url, :status => 301 }
      elsif request.put?
        @category.update_attributes(params[:category])
        format.json { head :ok }
        format.html
      else
        format.json { render :json => @category }
        format.html
      end
    end
  end

  def level
    @categories = Category.all
    respond_to do |format|
      format.json { render :json => {:categories => @categories}}
      format.html
    end
  end

  def category_destroy
    @customer = Customer.find(params[:customer_id])
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to category_customers_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end

  def add_user
    @category = Category.find(params[:id])
    @customers = Customer.all - Customer.where(:category => @category)
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> {
          :users => @users,
          :group => @group,
          :company_id => @company.id
      }
    }
    end
  end

  private

  def sort_column
    Customer.column_names.include?(params[:sort]) ? params[:sort] : "fullname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  #
  def xls_content_for(objs)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "Customers"

    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue

    sheet1.row(0).concat %w{ID 姓名 电话 地址 级别 性别 生日}
    count_row = 1

    objs.each do |obj|
      sheet1[count_row,0]=obj.id
      sheet1[count_row,1]=obj.fullname
      sheet1[count_row,2]=obj.phone
      sheet1[count_row,3]=obj.address
      sheet1[count_row,4]=obj.category
      sheet1[count_row,5]=obj.gender
      sheet1[count_row,6]=obj.birthday
      count_row = count_row + 1
    end

    book.write xls_report
    xls_report.string
  end
end
