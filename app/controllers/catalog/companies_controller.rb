=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::CompaniesController < ApplicationController
  before_action :set_company, only: [:show]
  layout 'catalog'
  
  # GET /catalog/companies
  # GET /catalog/companies.json
  def index
    #@companies = Company.all
    @companies = Company.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /catalog/companies/1
  # GET /catalog/companies/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name)
    end
end
