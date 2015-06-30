# coding: UTF-8
class ComplaintsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize
  before_filter :current_company

  layout "user"

  def index
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @complaints = @question.complaints.order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render :json => @car_buyings }
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @complaints = @question.complaints.order("created_at DESC")
    @complaint = Complaint.find(params[:id])
    respond_to do |format|
     format.html
     format.json { render :json => @complaint }
   end
  end

  def new
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @complaint = Complaint.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    if params[:complaint][:status]
    else
      params[:complaint][:status] = "已处理"
    end
    @complaint = Complaint.new(params[:complaint])
    respond_to do |format|
      if @complaint.save
        @question.complaints << @complaint
        @question.update_attributes(:status => params[:complaint][:status])
        #format.html
        format.json { render :json => @complaint, :status => :created }
      else
        format.html { render "new" }
        format.json { render :json => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @customer = @question.customer
    @complaint = Complaint.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @complaint }
    end
  end

  def update
    @complaint = Complaint.find(params[:id])
    respond_to do |format|
      if @complaint.update_attributes(params[:complaint])
        format.html
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render :json => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @complaint = Complaint.find(params[:id])
    @complaint.destroy
    respond_to do |format|
      format.html { render "index" }
      format.json { head :ok }
    end
  end
end