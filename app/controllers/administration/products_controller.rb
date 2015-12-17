=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::ProductsController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  # GET /administration/products
  # GET /administration/products.json
  def index
      @products = Product.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /administration/products/1
  # GET /administration/products/1.json
  def show
    #@product_images = @products.product_images.all
    @product_images = @product.product_images
  end

  # GET /administration/products/new
  # def new
  #   @product = Product.new
  #   @product_image = @product.product_images.build
  # end

  # GET /administration/products/1/edit
  def edit
     @product_image = @product.product_images.build
     @product_images = @product.product_images
  end

  # POST /administration/products
  # POST /administration/products.json
  # def create
  #   @product = Product.new(product_params)

  #   respond_to do |format|
  #     if @product.save
  #       params[:product_images]['image'].each do |i|
  #         @product_image = @product.product_images.create!(:image => i)
  #       end
  #       format.html { 
  #         redirect_to administration_products_path
  #         toast :success, "Товар был успешно создан."
  #       }
  #       format.json { render :show, status: :created, location: @product }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /administration/products/1
  # PATCH/PUT /administration/products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        params[:product_images]['image'].each do |i|
          @product_image = @product.product_images.create!(:image => i)
        end
        format.html { 
          redirect_to administration_products_path
          toast :success, "Товар был успешно обновлен."
        }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/products/1
  # DELETE /administration/products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { 
        redirect_to administration_products_url
        toast :success, "Товар был успешно удален."
      }
      format.json { head :no_content }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(
        :user_id,
        :category_id,
        :name,
        :on_sale,
        :ean13,
        :upc,
        :quantity,
        :minimal_quantity,
        :price,
        :wholesale_price,
        :unity,
        :additional_shipping_cost,
        :reference,
        :supplier_reference,
        :width,
        :height,
        :depth,
        :weight,
        :available_for_order,
        :available_date,
        :show_price,
        :visibility,
        :description,
        :short_description,
        :active,
        :featured,
        :stock_control,
        :meta_title,
        :meta_keywords,
        :meta_description,
        product_images_attributes: [:id, :product_id, :image]
      )
    end
end