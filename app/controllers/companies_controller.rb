=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class CompaniesController < ApplicationController
  before_action :login_required # the role
  before_action :role_required # the role
  # Обезательное расположение колбэков (поначалу сет обьекта, так как в нем есть глобальная переменная, потом проверка на owner).
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :owner_required, only: [:edit, :update, :destroy] # the role
  # GET /account/companies
  # GET /account/companies.json
  def index
    @company = current_user.company
    @featured_products = current_user.products.filter(params.slice(:status, :location, :starts_with)).last(12)
  end

  # GET /account/companies/1
  # GET /account/companies/1.json
  def show
    @featured_products = Product.filter(params.slice(:status, :location, :starts_with)).last(12)
  end

  # GET /account/companies/new
  def new
    @company = current_user.build_company
  end

  # GET /account/companies/1/edit
  def edit
  end

  # POST /account/companies
  # POST /account/companies.json
  def create
    @company = current_user.build_company(company_params)

    respond_to do |format|
      if @company.save
        format.html { 
          redirect_to company_path(@company)
          toast :success, "Компания была успешно создана."
        }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/companies/1
  # PATCH/PUT /account/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html {
          redirect_to company_path(@company)
          toast :success, "Компания была успешно обновлена."
        }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/companies/1
  # DELETE /account/companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
      # TheRole: object for ownership checking
      for_ownership_check(@company) # етот находиться в метод в aplication controller
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(
        :user_id,
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
end