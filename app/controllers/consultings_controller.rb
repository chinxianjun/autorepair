# coding: UTF-8
class ConsultingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company

  layout "user"

  def index
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @consultings = @question.consultings.order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render :json => @consultings }
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @consulting = Consulting.find(params[:id])
    @consultings = @question.consultings.order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render :json => @consulting }
    end
  end

  def new
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @consulting = Consulting.new
    respond_to do |format|
      format.html
      format.json { render :json => @consulting }
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    if params[:consulting]
      params[:consulting][:status] = "已答复"
    end
    @consulting = Consulting.new(params[:consulting])

    respond_to do |format|
      if @consulting.save|
        @question.consultings << @consulting
        if @question.status == "未处理"
          @question.update_attributes(:status => "已处理")
        end
        format.json { render :json => @consulting, :status => :created }
      else
        format.json { render :json => @consulting.errors, :status => 422 }
      end
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @consulting = Consulting.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @consulting }
    end
  end

  def update
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @consulting = Consulting.find(params[:id])
    respond_to do |format|
      if @consulting.update_attributes(params[:consulting])
        format.json { render :json => @consulting, :status => 200 }
      else
        format.json { render :json => @consulting.errors, :status => 422 }
      end
    end
  end

  def destroy
    @consulting = Consulting.find(params[:id])
    @consulting.destroy
    respond_to do |format|
      format.html { render "index" }
      format.json { head :ok }
    end
  end
end
