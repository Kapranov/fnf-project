=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Users::RegistrationsController < Devise::RegistrationsController 
  layout 'catalog', :only => [:new]
end