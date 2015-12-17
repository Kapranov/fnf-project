=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Users::SessionsController < Devise::SessionsController
  layout 'catalog'
  def new
    super
  end

  def create
    super
  end

  # def after_sign_in_path_for(resource)
  #   if not current_user.role_name ==  'admin'
  #     if resource.sign_in_count < 5
	 #      welcome_path
	 #      toast :success, "welcome"
	 #    else
  #       dashboard_path
  #   	end
  #   else
  #     administration_dashboard_path
  #   end
  # end

  # def after_sign_out_path_for(resource)
  #   new_user_session_path
  # end
end