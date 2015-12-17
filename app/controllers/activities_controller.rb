=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class ActivitiesController < ApplicationController
  def index
  	# @activities = PublicActivity::Activity.all.order(created_at: :desc)
  	@activities = PublicActivity::Activity.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end
end
