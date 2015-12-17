=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class TrademarksController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :owner_required, only: [:edit, :update, :destroy]
  before_action :set_trademark, only: [:show, :edit, :update, :destroy]

  # GET /account/trademarks
  # GET /account/trademarks.json
  def index
    #@trademarks = Trademark.paginate(:page => params[:page], :per_page => 30)
    @trademarks = current_user.trademarks.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /account/trademarks/1
  # GET /account/trademarks/1.json
  def show
  end

  # GET /account/trademarks/new
  def new
    if current_user.company.nil?
      toast :warning, "Что бы добавить торговую марку сперва добавьте свою компанию."
      redirect_to companies_path
    else
      @trademark = current_user.company.trademarks.build(user_id: current_user.id, company_id: current_user.company.id)
    end
  end

  # GET /administration/trademarks/1/edit
  def edit
  end

  # POST /account/trademarks
  # POST /account/trademarks.json
  def create
    @trademark = current_user.trademarks.build(trademark_params)    
    respond_to do |format|
      if @trademark.save
        format.html {
          if params[:stay] 
            redirect_to edit_trademark_path(@trademark)
            toast :success, "Торговая марка #{@trademark.name} была успешно создана."
          else
            redirect_to trademarks_path
            toast :success, "Торговая марка #{@trademark.name} была успешно создана."
          end
        }
        format.json { render :show, status: :created, location: @trademark }
      else
        format.html { render :new }
        format.json { render json: @trademark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/trademarks/1
  # PATCH/PUT /account/trademarks/1.json
  def update
    respond_to do |format|
      if @trademark.update(trademark_params)
        format.html {
          if params[:stay] 
            redirect_to edit_trademark_path(@trademark)
            toast :success, "Торговая марка #{@trademark.name} была успешно обновлена."
          else
            redirect_to trademarks_path
            toast :success, "Торговая марка #{@trademark.name} была успешно обновлена."
          end
        }
        format.json { render :show, status: :ok, location: @trademark }
      else
        format.html { render :edit }
        format.json { render json: @trademark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/trademarks/1
  # DELETE /account/trademarks/1.json
  def destroy
    @trademark.destroy
    respond_to do |format|
      format.html { 
        redirect_to trademarks_url
        toast :success, "Торговая марка была успешно удалена." 
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trademark
      @trademark = Trademark.find(params[:id])
      # TheRole: object for ownership checking
      for_ownership_check(@trademark)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trademark_params
      params.require(:trademark).permit(
        :user_id,
        :company_id,
        :name,
        :description,
        :logo,
        :registration_date,
        :meta_title,
        :meta_keywords,
        :meta_description,
        :state_event
      )
    end
end