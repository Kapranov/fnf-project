=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class ApplicationController < ActionController::Base
  include TheRole::Controller

  include PublicActivity::StoreController
  
  protect_from_forgery with: :exception
  helper_method :full_name_user, :avatar, :toast
  

  before_action :configure_permitted_parameters, if: :devise_controller?

  
  # layout :layout_by_resource

  # before_filter :set_search

  # for ransack
  # def set_search
  #   @q = Product.ransack(params[:q])
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password) 
    }
  end

  def access_denied
    toast :error, t('the_role.access_denied')
    redirect_to :back rescue redirect_to root_path
  end

  def full_name_user user
    begin
    "#{user.first_name} #{user.last_name}"
    rescue
      nil
    end
  end # full_name_user

  def toast type, text
    flash[:toastr] = { type => text }
  end 

  private

    def for_ownership_check obj
      @owner_check_object = obj
    end

    # def my_special_ownership_check
    #   role_access_denied unless current_user.try(:is_owner_of?, @owner_check_object)
    # end 

    def after_sign_in_path_for resource
    if not current_user.role_name == 'admin'
      dashboard_path
    else
      administration_dashboard_path
    end
  end

  def after_sign_out_path_for resource
    new_user_session_path
  end
end