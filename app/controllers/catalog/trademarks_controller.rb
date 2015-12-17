=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::TrademarksController < ApplicationController
  before_action :set_trademark, only: [:show]
  layout 'catalog'
  
  # GET /catalog/trademarks
  # GET /catalog/trademarks.json
  def index
    @trademark = Trademark.all
  end

  # GET /catalog/trademarks/1
  # GET /catalog/trademarks/1.json
  def show
    @featured_products = Product.filter(params.slice(:status, :location, :starts_with)).last(12)
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trademark
      @trademark = Trademark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def trademark_params
    #   params.require(:trademark).permit(:name, :description, :user_id, :company, :company_id)
    # end
end
