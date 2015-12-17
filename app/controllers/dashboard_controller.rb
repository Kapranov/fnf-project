=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    #redirect_to administration_dashboard_path if current_user.administration?
  end

  

end
