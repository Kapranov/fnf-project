=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::CustomersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_customer, only: [:show, :follow, :unfollow]
  layout 'catalog'
  
  def show
    if @customer.company.try(:any?)
      @featured_products = @customer.company.products.filter(params.slice(:status, :location, :starts_with)).last(12)
    else
      #redirect_to :root
      @featured_products = nil
      toast :error, "Ошибка."
    end
  end

  def follow
    respond_to do |format|
      if current_user.follow!(@customer)
        format.js
      end
    end 
  end

  def unfollow
    respond_to do |format|
      if current_user.unfollow!(@customer)
         format.js
      end
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = User.find(params[:id])
    end
end