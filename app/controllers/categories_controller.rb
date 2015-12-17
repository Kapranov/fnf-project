=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    #@categories = Category.all
    @categories = Category.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    # alls categories
    @categories = Category.all
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
          redirect_to @category
          # toast :success, t('category_successfully_created')
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
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
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
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      begin
      @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Категория не найдена."
        redirect_to categories_path
      end
    end

    def category_params
      params.require(:category).permit(
        :name,
        :description,
        :meta_title,
        :meta_keywords,
        :meta_description
      )
    end
end
