=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class ErrorsController < ApplicationController  
  before_filter :authenticate_user!, except: [:show]
  layout 'errors', only: [:show]

  def show
    render status_code.to_s, :status => status_code
  end

  protected

    def status_code
      params[:code] || 500
    end
end
