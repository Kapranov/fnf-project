=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::CompaniesController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    # @companies = Company.all
    # @companies = Company.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    @search = Company.search(params[:q])
    @companies = @search.result.paginate(:page => params[:page], :per_page => 30)
  end

  def published
    @companies = Company.published.paginate(:page => params[:page], :per_page => 30)
  end

  def pending
    @companies = Company.pending.paginate(:page => params[:page], :per_page => 30)
  end

  def editing
    @companies = Company.editing.paginate(:page => params[:page], :per_page => 30)
  end

  def denied
    @companies = Company.denied.paginate(:page => params[:page], :per_page => 30)
  end

  def trashed
    @companies = Company.trashed.paginate(:page => params[:page], :per_page => 30)
  end

  def removed
    @companies = Company.removed.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  # def new
  #   @company = Company.new
  # end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  # def create
  #   @company = Company.new(company_params)

  #   respond_to do |format|
  #     if @company.save
  #       format.html { 
  #         redirect_to administration_company_path(@company)
  #         toast :success, "Компания была успешно создана."
  #       }
  #       format.json { render :show, status: :created, location: @company }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @company.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { 
          redirect_to administration_company_path(@company)
          toast :success, "Компания была успешно обновлена."
        }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { 
        redirect_to administration_companies_url
        toast :success, "Компания была успешно удалена."
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(
        :logo,
        :name,
        :description,
        :business_entity,
        :vatcode,
        :company_id_number,
        :cea,
        :registration_date,
        :address,
        :meta_title,
        :meta_keywords,
        :meta_description,
        :state_event
      )
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
