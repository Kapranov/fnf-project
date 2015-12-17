=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class AccountController < ApplicationController
  before_action :authenticate_user!
 
  def index
    render profile
  end

  def profile
    @user = User.find(current_user.id)
  end

  def my_favorite_products
    
    product = current_user.mentionees(Product)

    @my_favorite_products = product 
  end

  def edit_profile
    @user = User.find(current_user.id) 
  end

  def update_profile
    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update(user_params)
        format.html {
          redirect_to profile_path
          toast :success, "Профайл обновлен"
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

   

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role,
      :note,
      :about,
      :avatar
    )
  end

end
