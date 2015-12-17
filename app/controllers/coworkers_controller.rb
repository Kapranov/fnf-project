=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class CoworkersController < ApplicationController
  before_action :authenticate_user!
	before_action :role_required

	def index 
  	@employee = User.paginate(:page => params[:page], :per_page => 10).order(last_name: :desc)
  end 
  
  def show 
  	redirect_to user_path(params[:id]) 
  end 
  
  def new 
  	@cooperation1 = Cooperation.new 
  	@cooperation2 = Cooperation.new 
  end 
  
  def create 
  	@user = User.find(current_user) 
  	@coworker = User.find(params[:coworker_id]) 
  	params[:cooperation1] = {:user_id => @user.id, :coworker_id => @coworker.id, :status => 'requested'} 
  	params[:cooperation2] = {:user_id => @coworker.id, :coworker_id => @user.id, :status => 'pending'} 
  	@cooperation1 = Cooperation.create(params[:cooperation1]) 
  	@cooperation2 = Cooperation.create(params[:cooperation2]) 
  	if @cooperation1.save && @cooperation2.save 
  		redirect_to user_coworkers_path(current_user) 
  	else 
  		redirect_to user_path(current_user) 
  	end 
  end 
  
  def update 
  	@user = User.find(current_user) 
  	@coworker = User.find(params[:id]) 
  	params[:cooperation1] = {:user_id => @user.id, :coworker_id => @coworker.id, :status => 'accepted'} 
  	params[:cooperation2] = {:user_id => @coworker.id, :coworker_id => @user.id, :status => 'accepted'} 
  	@cooperation1 = Cooperation.find_by_user_id_and_coworker_id(@user.id, @coworker.id) 
  	@cooperation2 = Cooperation.find_by_user_id_and_coworker_id(@coworker.id, @user.id) 
  	if @cooperation1.update_attributes(params[:cooperation1]) && @cooperation2.update_attributes(params[:cooperation2]) 
  		flash[:notice] = 'Coworker sucessfully accepted!' 
  	redirect_to user_coworkers_path(current_user) 
  	else 
  		redirect_to user_path(current_user) 
  	end 
  end 
  
  def destroy 
  	@user = User.find(params[:user_id]) 
  	@coworker = User.find(params[:id]) 
  	@cooperation1 = @user.cooperation.find_by_coworker_id(params[:id]).destroy 
  	@cooperation2 = @coworker.cooperation.find_by_user_id(params[:id]).destroy 
  	redirect_to user_coworkers_path(:user_id => current_user) 
  end 
end
