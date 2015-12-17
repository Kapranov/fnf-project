=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::DashboardController < ApplicationController
  before_action :login_required
  before_action :role_required

  def index
    @users = User.all
  end
end
