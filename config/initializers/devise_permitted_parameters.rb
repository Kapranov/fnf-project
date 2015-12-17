=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
module DevisePermittedParameters
  extend ActiveSupport::Concern 

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    ) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :remember_me
    ) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :note,
      :about,
      :avatar
    ) }
  end

end

DeviseController.send :include, DevisePermittedParameters
