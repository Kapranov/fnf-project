=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Account::StepsController < ApplicationController
  before_action :login_required
  
  layout 'devise'
  
  include Wicked::Wizard
  steps *User.form_steps

  @administration_roles = ["admin", "moderator", "operator"]

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update(account_params(step))
    render_wizard @user unless step == "about" 
    # if step == "type_of_account"
    #   case params[:role]
    #     when "1"
    #       @user.role_id = Role.with_name(:manufacturer)
    #       @user.save!
    #       redirect_to(dashboard_path) and return
    #       toast :success, "Регистрация прошла успешно."
    #     when "2"
    #       @user.role_id = Role.with_name(:distributor)
    #       @user.save!
    #       redirect_to(dashboard_path) and return
    #       toast :success, "Регистрация прошла успешно."
    #     when "3"
    #       redirect_to(root_path) and return
    #       toast :success, "Регистрация прошла успешно."
    #   end
    # end
    if step == "about"
      if params[:upload_avatar] 
        respond_to do |format|
          if @user.save
            format.html {
              if params[:user][:avatar].present?
                render :about  ## Render the view for cropping
              else
                render_wizard @user
              end
            }
             
          else
            format.html { render_wizard @user }
             
          end
        end
      else
        render_wizard @user
      end
    end
  end

  private

  def finish_wizard_path
    
    if current_user.role_name == "manufacturer"
      account_manufacturer_step_path(Company.form_steps.first)
    elsif current_user.role_name == "distributor"
      account_distributor_step_path(Company.form_steps.first)
    elsif current_user.role_name.include? "admin" or current_user.role_name.include? "moderator" or current_user.role_name.include? "operator" or current_user.role_name.nil?
      current_user.delete
      toast :success, "Не умничай."
      root_path
    else
      dashboard_path
      #toast :success, "Регистрация прошла успешно."
    end

  end

  def account_params(step)
    permitted_attributes = case step
      when "identity"
        [:first_name, :last_name]
      when "location"
        [:province, :city]
      when "about"
        [:post, :about, :avatar, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h]
      when "type_of_account"
        [:role_id]
     end
    params.require(:user).permit(permitted_attributes).merge(form_step: step)
  end

end