=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::SettingsController < ApplicationController
  def update
    Setting.update_from_hash(params[:settings].permit!)
    redirect_to :settings, :notice => t('settings.update_notice')
  end

end