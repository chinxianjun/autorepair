# coding: utf-8
class MyController < ActionController
  def index

  end

  def setting
    @default_company = Company.find(params[:id])
    User.default_company=(@default_company)
    respond_to do |format|
      format.html { redirect_to my_path }
    end
  end
end