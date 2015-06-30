# coding: UTF-8
class PartBuyingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company

  layout "user"

  def index
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @part_buyings = @question.part_buyings.order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render :json => @part_buyings }
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @part_buying = PartBuying.find(params[:id])
    @part_buyings = @question.part_buyings.order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render :json => @part_buying }
    end
  end

  def new
    @question = Question.find(params[:question_id])
    @part_buying = PartBuying.new
    @salesman = current_company.salesman

    respond_to do |format|
      format.html
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @part_buying = PartBuying.new(params[:part_buying])
    respond_to do |format|
      if @part_buying.save
        if params[:part_buying][:status]
          @question.update_attributes(:status => params[:part_buying][:status],
                                    :processor => params[:part_buying][:manager])
        end
        @question.part_buyings << @part_buying
        #format.html
        format.json { render :json => @part_buying, :status => :created }
      else
        format.html { render "new" }
        format.json { render :json => @part_buying.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_salesman
    @question = Question.find(params[:question_id])
    @salesman = @current_company.salesman
    @part_buying = PartBuying.find(params[:id])
    @customer = @question.customer
    if request.post?
      @add_part_buying = PartBuying.new(:salesman => params[:salesman],
                                    :manager => current_user.fullname,
                                    :description => params[:description],
                                    :referral => params[:referral],
                                    :status => "洽谈")
      respond_to do |format|
        if @add_part_buying.save
          @question.part_buyings << @add_part_buying
          @question.update_attributes(:status => "洽谈")

          format.html { redirect_to question_part_buyings_path(@question) }
          format.json { render :json => @add_part_buying, :status => :created }
        else
          format.html { render "add_salesman" }
          format.json { render :json => @add_part_buying.errors, :status => :unprocessable_entity }
        end
      end
    end
  end


  def edit
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @part_buying = PartBuying.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @part_buying}
    end
  end

  def update
    @part_buying = PartBuying.find(params[:id])
    respond_to do |format|
      if @part_buying.update_attributes(params[:part_buying])
        format.html
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render :json => @part_buying.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @part_buying = PartBuying.find(params[:id])
    @part_buying.destroy
    respond_to do |format|
      format.html { render "index" }
      format.json { head :ok }
    end
  end
end
