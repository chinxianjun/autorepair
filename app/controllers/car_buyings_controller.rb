# coding: UTF-8
class CarBuyingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company

  layout "user"

  def index
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    if @question.car_buyings.where(:manager => current_user.fullname).any?
      @car_buyings = @question.car_buyings.where(:manager => current_user.fullname).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    elsif @question.car_buyings.where(:salesman => current_user.fullname).any?
      @car_buyings = @question.car_buyings.where(:salesman => current_user.fullname).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    else
      @car_buyings = @question.car_buyings.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end
    respond_to do |format|
      format.html
      format.json { render :json => @car_buyings }
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @car_buyings = @question.car_buyings.order("created_at DESC")
    @car_buying = CarBuying.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @car_buying }
    end
  end

  def new
    @question = Question.find(params[:question_id])
    @car_buying = CarBuying.new
    @salesman = current_company.salesman

    respond_to do |format|
      format.html
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @car_buying = CarBuying.new(params[:car_buying])
    respond_to do |format|
      if @car_buying.save
        if params[:car_buying][:status]
          @question.update_attributes(:status => params[:car_buying][:status],
                                    :processor => params[:car_buying][:manager])
        end
        @question.car_buyings << @car_buying
        #format.html
        format.json { render :json => @car_buying, :status => :created }
      else
        format.html { render "new" }
        format.json { render :json => @car_buying.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_salesman
    @question = Question.find(params[:question_id])
    @salesman = @current_company.salesman.users
    @car_buying = CarBuying.find(params[:id])
    @customer = @question.customer
    if request.post?
      @add_car_buying = CarBuying.new(:salesman => params[:salesman],
                                    :manager => current_user.fullname,
                                    :description => params[:description],
                                    :referral => params[:referral],
                                    :status => "洽谈")
      if params[:history]
        history = History.new(params[:history])
        history.save
      end
      respond_to do |format|
        if @add_car_buying.save
          @question.update_attributes(:status => "洽谈")
          @question.car_buyings << @add_car_buying

          format.html { redirect_to question_car_buyings_path(@question) }
          format.json { render :json => @add_car_buying, :status => :created }
        else
          format.html { render "add_salesman" }
          format.json { render :json => @add_car_buying.errors, :status => :unprocessable_entity }
        end
      end
    end
  end


  def edit
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @car_buying = CarBuying.find(params[:id])
    @salesman = @current_company.salesman.users
    respond_to do |format|
      format.html
      format.json { render :json => @car_buying}
    end
  end

  def update
    @car_buying = CarBuying.find(params[:id])
    respond_to do |format|
      if @car_buying.update_attributes(params[:car_buying])
        format.html
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render :json => @car_buying.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @car_buying = CarBuying.find(params[:id])
    @car_buying.destroy
    respond_to do |format|
      format.html { render "index" }
      format.json { head :ok }
    end
  end
end


