=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class SettingsController < ApplicationController
  before_filter :authenticate_user!, except: [:change_locale]

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:FnfEstore_locale] = l
    redirect_to request.referer || root_url
  end
end
