=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Account::DistributorStepsController < ApplicationController
  before_action :login_required
  
  layout 'devise'
  
  include Wicked::Wizard
  steps *Company.form_steps

  def show
    if Company.form_steps.first
      @company = Company.find_or_initialize_by(user_id: current_user)
    else
      @company = current_user.company
    end
    render_wizard
  end

  def update
    if Company.form_steps.first && current_user.company.nil?
      @company = current_user.build_company(type_company: "distributor")
    else
      @company = current_user.company
    end

    @company.update(steps_params(step))
    render_wizard @company 
  end

  private

  def finish_wizard_path
    dashboard_url    
  end

  def steps_params(step)
    permitted_attributes = case step
      when "information"
        [:name, :description]
      when "requisites"
        [:business_entity, :vatcode, :company_id_number, :cea, :registration_date]
      when "seo"
        [:meta_title, :meta_description, :meta_keywords]
      when "logo"
        [:logo]
      when "attachments"
        [:attachments]
     end
    params.require(:company).permit(permitted_attributes).merge(form_step: step)
  end

end