=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  image            :string(255)
#  lft              :integer          not null
#  rgt              :integer          not null
#  depth            :integer          default(0), not null
#  children_count   :integer          default(0), not null
#  name             :string(255)
#  description      :text(65535)
#  meta_title       :string(255)
#  meta_keywords    :string(255)
#  meta_description :text(65535)
#  status           :string(255)      default("published")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name)
#

class Category < ActiveRecord::Base
	# activities based dem PublicActivity
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
	
  # Tree structure based gem awesome_acts_as_nested_set
  acts_as_nested_set
  
  after_move :rebuild_slug
  around_move :da_fancy_things_around
  
  # image of category based gem CarrierWave 
  mount_uploader :image, CategoryImageUploader

  belongs_to :parent, class_name: "Category"
  has_many :childrens, class_name: "Category", foreign_key: "parent_id", :counter_cache => :children_count
  has_many :products

  # translates :name, :description, fallbacks_for_empty_translations: true

  # Validation
  validates :name, :description, presence: true

  # Scopes
  # Root (no parent) categories only
  scope :without_parent, -> { where(parent_id: nil) }
  # Parent categories only
  scope :parent_categories, ->(category) { where(parent_id: category) if category.present? }

  def parent_name
    # it may not have a parent
    parent.try(:name)
  end

  def has_parent?
    parent.present?
  end

  def has_children?
    children.exists?
  end

  private

  def rebuild_slug
    # do whatever
  end

  def da_fancy_things_around
    # do something...
    yield # actually moves
    # do something else...
  end
end
