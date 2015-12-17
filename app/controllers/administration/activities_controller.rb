=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end 
class Administration::ActivitiesController < ApplicationController
  before_action :login_required
  before_action :role_required

  def index
  	#@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.brand_ids, owner_type: "User")
  	@activities = PublicActivity::Activity.all.order("created_at desc").paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end
end