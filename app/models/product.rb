=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  category_id         :integer
#  company_id          :integer
#  trademark_id        :integer
#  name                :string(255)
#  description         :text(65535)
#  ean13               :string(255)
#  price               :decimal(12, 3)
#  reference           :string(255)
#  supplier_reference  :string(255)
#  width               :string(255)
#  height              :string(255)
#  depth               :string(255)
#  weight              :decimal(12, 3)
#  available_for_order :string(255)
#  available_date      :string(255)
#  show_price          :string(255)
#  visibility          :integer
#  status              :string(255)      default("published")
#  meta_title          :string(255)
#  meta_keywords       :string(255)
#  meta_description    :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#

class Product < ActiveRecord::Base
  include Filterable # my concerns based tutorial http://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  # gem "socialization"
  acts_as_likeable

  # acts_as_mentionable
  acts_as_mentionable

  # associations
  belongs_to :user # user owner
  belongs_to :company 
  belongs_to :trademark
  belongs_to :category
  
  has_many :product_images # association 
  validates_associated :product_images
  # validation 
  #validates :user, presence: true # user owner

  validates :category, presence: true # validate association with category 
  validates :trademark, presence: true # validate association with trademark 

  validates :name, :description, :ean13, :reference, presence: true
  validates :name,        length: { in: 6..60 }

  validates :description, length: {
    minimum: 10,
    maximum: 1000,
    # tokenizer: lambda { |str| str.split(/\s+/) },
    too_short: "должно быть по крайней мере %{count} знаков",
    too_long: "должно быть не более %{count} знаков"
  }

  accepts_nested_attributes_for :product_images, allow_destroy: true
  
  
  #before_create :generate_reference
  
  # validates :terms_of_service, acceptance: true

  # reference number for product assigned fnf
  # def generate_reference
  #   self.reference = [*00000000..99999999].sample
  #   save!
  # end

  # Ordered items which are associated with this product
  has_many :order_items, :dependent => :restrict_with_exception, :as => :ordered_item

  # Orders which have ordered this product
  has_many :orders, :through => :order_items


  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
