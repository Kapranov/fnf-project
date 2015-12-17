=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::TrademarksController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_trademark, only: [:show, :edit, :update, :destroy]

  # GET /administration/trademarks
  # GET /administration/trademarks.json
  def index
    @trademarks = Trademark.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /administration/trademarks/1
  # GET /administration/trademarks/1.json
  def show
  end

  # GET /administration/trademarks/new
  # def new
  #   @trademark = Trademark.new
  # end

  # GET /administration/trademarks/1/edit
  def edit
  end

  # POST /administration/trademarks
  # POST /administration/trademarks.json
  # def create
  #   @trademark = Trademark.new(trademark_params)

  #   respond_to do |format|
  #     if @trademark.save
  #       format.html {
  #         if params[:stay] 
  #           redirect_to edit_administration_trademark_path(@trademark)
  #           toast :success, "Торговая марка #{@trademark.name} была успешно создана."
  #         else
  #           redirect_to administration_trademarks_path
  #           toast :success, "Торговая марка #{@trademark.name} была успешно создана."
  #         end
  #       }
  #       format.json { render :show, status: :created, location: @trademark }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @trademark.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /administration/trademarks/1
  # PATCH/PUT /administration/trademarks/1.json
  def update
    respond_to do |format|
      if @trademark.update(trademark_params)
        format.html {
          if params[:stay] 
            redirect_to edit_administration_trademark_path(@trademark)
            toast :success, "Торговая марка #{@trademark.name} была успешно обновлена."
          else
            redirect_to administration_trademarks_path
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

  # DELETE /administration/trademarks/1
  # DELETE /administration/trademarks/1.json
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trademark_params
      params.require(:trademark).permit(:name, :description, :user_id, :company_id)
    end
end
