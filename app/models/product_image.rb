=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end 
# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  product_id :integer
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :product
  # validates :image, file_size: { in: 100.kilobytes..15.megabyte }

end