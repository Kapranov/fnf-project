=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Catalog::WelcomeController < ApplicationController
  layout 'catalog'
  
  def index
  	@featured_products = Product.filter(params.slice(:status, :location, :starts_with)).last(12)
	@root_categories = Category.without_parent
  end

end