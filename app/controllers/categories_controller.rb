#coding: utf-8

class CategoriesController < ApplicationController

  def destroy
    @customer = Customer.find(params[:customer_id])
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      #format.html { redirect_to customers_index_path }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end
end