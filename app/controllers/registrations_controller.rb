class RegistrationsController < Devise::RegistrationsController
  layout 'devise', :only => [:new]
  
  before_action :configure_permitted_parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :terms_of_service)
    end 
  end

  protected

    def after_sign_up_path_for(resource)
      account_step_path(User.form_steps.first)
    end

    def after_inactive_sign_up_path_for(resource)
      account_step_path(User.form_steps.first)
    end
end