=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :like, :unlike, :favorite, :unfavorite]
  layout 'catalog'
  helper_method :sort_column, :sort_direction
  
  # GET /catalog/products
  # GET /catalog/products.json
  def index
      @products = Product.filter(params.slice(:status, :location, :starts_with)).paginate(:page => params[:page], :per_page => 12)
      #@products = Product.paginate(:page => params[:page], :per_page => 30)    
  end

  # GET /catalog/products/1
  # GET /catalog/products/1.json
  def show
    #@product_images = @products.product_images.all
    @product_images = @product.product_images
  end
 
  def like
    respond_to do |format|
      if current_user.like!(@product)
        format.js  
      end   
    end
  end

  def unlike
    respond_to do |format|
      if current_user.unlike!(@product)
        format.js  
      end
    end
  end

  def favorite
    respond_to do |format|
      if current_user.mention!(@product)
        format.js
      end
    end
  end

  def unfavorite
    respond_to do |format|
      if current_user.unmention!(@product)
        format.js
      end
    end
  end

  private

    def search_params
      default_params = {}
      default_params.merge({user_id_eq: current_user.id}) if signed_in?
      # more logic here
      params[:q].merge(default_params)
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_search
      @search = Product.search(params[:q])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

end