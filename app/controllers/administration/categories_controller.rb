=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::CategoriesController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    #@categories = Category.all.paginate(:page => params[:page], :per_page => 10)
    @categories = Category.paginate(:page => params[:page], :per_page => 10)
  end

  def show
   # alls categories
    @categories = Category.parent_categories(@category)
    # current category
    @category = Category.find(params[:id])
    
    #@activities = PublicActivity::Activity.order("created_at DESC").where(trackable_type: "Category", trackable_id: @category).all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html {
          if params[:stay] 
            redirect_to edit_administration_category_path(@category)
            toast :success, "Категория #{@category.name} была успешно создана."
          else
            redirect_to administration_categories_path
            toast :success, "Категория #{@category.name} была успешно создана."
          end
        }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {
          if params[:stay] 
            redirect_to edit_administration_category_path(@category)
            toast :success, "Категория #{@category.name} была успешно обновлена."
          else
            redirect_to administration_categories_path
            toast :success, "Категория #{@category.name} была успешно обновлена."
          end
        }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { 
        redirect_to administration_categories_url
        toast :success, "Категория была успешно удалена."
      }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      begin
      @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        toast :success, "Категория не найдена."
        toast :success, "Категория под номером #{params[:id]} не найдена."
        
        redirect_to administration_categories_path
      end
    end

    def category_params
      params.require(:category).permit(
        :name,
        :description,
        :meta_title,
        :meta_keywords,
        :meta_description,
        :status,
        :parent_id,
        :lft,
        :rgt,
        :depth,
        :children_count
      )
    end
end