=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  layout 'catalog'
  
  # GET /catalog/categories
  # GET /catalog/categories.json
  def index
    @categories = Category.all
  end

  # GET /catalog/categories/1
  # GET /catalog/categories/1.json
  def show
    @products = Product.filter(params.slice(:status, :location, :starts_with)).last(12)
    @categories = Category.find(params[:id]).childrens
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def trademark_params
    #   params.require(:trademark).permit(:name, :description, :user_id, :company, :company_id)
    # end
end
