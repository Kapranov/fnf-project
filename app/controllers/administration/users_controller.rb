=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::UsersController < ApplicationController

  before_action :login_required
  before_action :role_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]

#before_action :set_audit, only: %w[create show update edit destroy]
# GET administration/users
# GET administration/users.json
def index
  #@users = User.includes(:role)
  @users = User.includes(:role).order(last_name: :asc).all
end

  # GET administration/users/1
  # GET administration/users/1.json
  def show
  end

  # GET administration/requests/new
  # 'new' page is form for sign in 
  def new
    @user = User.new
  end

  # GET administration/users/1/edit
  def edit
  end

  # POST administration/users
  # POST administration/users.json
  # 'create' is not a page is resiver of post method of sign in form  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, success: "Thank you for signing up!"
    else
      render "new"
      #redirect_to login_path
    end
  end

  # PATCH/PUT administration/users/1
  # PATCH/PUT administration/users/1.json
  def update
      respond_to do |format|
          if @user.update(user_params)
              format.html { redirect_to admin_users_path(@user), success: 'User was successfully updated.' }
              format.json { render :show, status: :ok, location: @user }
          else
              format.html { render :edit }
              format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end
  end

  # DELETE administration/users/1
  # DELETE administration/users/1.json
  def destroy
      @user.destroy
      respond_to do |format|
          format.html { redirect_to users_url, success: 'User was successfully destroyed.' }
          format.json { head :no_content }
      end
  end

  def change_role
      @user = User.find params[:user_id]
      @role = Role.find params[:role_id]
      @user.update_attribute(:role, @role)
      redirect_to redirect_to @user
  end

  def change_currency
      @user = current_user
      if request.post?
          #@user.update_attributes(params[:user][:currency_id])
          if @user.update_attributes(currency_params) 
              redirect_to profile_path, success: t('Default_currency_has_changed_from_now_will_see_prices_in, attribute: @user.currency')
          else
              redirect_to change_currency_path, error: t('Your_currency_has_not_been_changed')
          end
      end # request.post?
  end

  def change_time_zone
      @user = current_user
      if request.post?
          if @user.update_attributes(time_zone_params)
              redirect_to profile_path, success: t('Time_Zone_has_been_changed')
          else
              redirect_to change_time_zone_path, error: t('Time_Zone_has_not_been_changed')
          end
      end # request.post?
  end

  def change_language
      @user = current_user
      if request.post?
          @user.language = params[:user][:language]
          
          #@user.update_attribute(params[:user][:language])
          respond_to do |format|
              if @user.save
                  format.html { redirect_to :action => :profile and flash[:success] = I18n.t('Language_is_changed_to') +' '+ I18n.t(@user.language, :scope => 'languages.names') }
                  format.json { render json: @user.language, status: :created }
              else
                  format.html { flash[:error] = t('Language_no_changed') and render :action => :change_language }
                  format.json { render json: @user.errors, status: :unprocessable_entity }
              end
          end # request.post?
      end
  end

  # 'profile' page
  def profile
      @user = current_user
      #puts current_user.inspect
      if request.post?    
          if @user.update_attributes(profile_params)
              redirect_to profile_path, notice: t('Successfully_your_profile_has_been_updated.')
              session[:first_name] = @user.first_name
              session[:last_name] = @user.last_name
          else
              redirect_to profile_path, error: t('Your_profile_no_has_been_updated')
          end
      end # request.post?
  end # profile

  def profile_update
      @user = current_user
      if @user.update_attributes(profile_params)
          redirect_to profile_path, success: t('Successfully changed password.')     
          session[:first_name] = @user.first_name
          session[:last_name] = @user.last_name
      else
          redirect_to profile_path, error: t('Your_profile_no_has_been_updated')
      end
  end

  # 'dashboard' page
  def dashboard
      @user = current_user
      @full_name = full_name_user(@user)
      unless @user
        redirect_to logout_path and return false
      end       
  end # dashboard

  # 'avatar' page
  def avatar
      @user = current_user
      if request.post?
          @user.changing_avatar = true
          if @user.update_attributes(avatar_params)        
              flash[:success] = t :Profile_picture_is_changed
              redirect_to profile_path
          else
              flash[:error] = t :Profile_picture_has_not_been_changed
              render action: :avatar
          end
      end # request.post?
  end # avatar

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        begin
            @user = User.find params[:id]
            # TheRole: You should define OWNER CHECK OBJECT
            # When editable object was found
            @owner_check_object = @user
        rescue ActiveRecord::RecordNotFound
            flash[:alert] = "The User you were looking for could not be found."
            redirect_to admin_users_path
        end
    end

    # 'user_params' is params for create user in sign in page
    def user_params
        params.require(:user).permit(
            :role_id, :email, :password, :password_confirmation, :first_name, :last_name, :birthday, :gender, :country, :province, :city, :mobile, :landline, :language, :subscribed
        )
    end # user_params

    # 'profile_params' is params for update profile page
    def avatar_params
        params.require(:user).permit(:avatar)
    end # avatar_params

    # 'profile_params' is params for update profile page
    def profile_params
        params.require(:user).permit(
            :first_name, :last_name, :birthday, :gender, :country, :city, :province, 
            :email, :mobile, :landline
        )
    end # profile_params

    # 'currency_params' is params for update currency atribute in change_currency page
    def currency_params
        params.require(:user).permit(:currency)
    end # currency_params

    # 'currency_params' is params for update currency atribute in change_currency page
    def time_zone_params
        params.require(:user).permit(:time_zone)
    end # currency_params
end