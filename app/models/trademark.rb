=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
# == Schema Information
#
# Table name: trademarks
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  company_id        :integer
#  logo              :string(255)
#  name              :string(255)
#  description       :text(65535)
#  website           :string(255)
#  registration_date :date
#  meta_title        :string(255)
#  meta_keywords     :string(255)
#  meta_description  :text(65535)
#  status            :string(255)      default("published")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_trademarks_on_company_id  (company_id)
#  index_trademarks_on_user_id     (user_id)
#

class Trademark < ActiveRecord::Base  
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  mount_uploader :logo, LogoUploader

  belongs_to :user
  belongs_to :company

  has_many :products


  # validation for steps registration and add company and others... trademark, product
  cattr_accessor :form_steps do
    %w(information requisites seo logo)
  end

  attr_accessor :form_step

  # with_options if: -> { required_for_step?(:information) } do |step|
  #   step.validates :name, presence: true
  #   step.validates :description, presence: true
  # end

  # with_options if: -> { required_for_step?(:requisites) } do |step|
  #   step.validates :business_entity, presence: true
  #   step.validates :vatcode, presence: true
  #   step.validates :company_id_number, presence: true
  #   step.validates :cea, presence: true
  #   step.validates :registration_date, presence: true
  # end

  # with_options if: -> { required_for_step?(:seo) } do |step|
  #   step.validates :meta_title, presence: true
  #   step.validates :meta_description, presence: true
  #   #step.validates :meta_keywords, presence: true
  # end

  # with_options if: -> { required_for_step?(:logo) } do |step|
  #   step.validates :logo, presence: true
  # end

  #validates :name, :description, presence: true, if: -> { required_for_step?(:information) }
  #validates :business_entity, :vatcode, :company_id_number, :cea, :registration_date, presence: true, if:  -> { required_for_step?(:requisites) }
  #validates :meta_title, :meta_description, :meta_keywords, presence: true, if: -> { required_for_step?(:seo) }
  #validates :logo, presence: true, if: -> { required_for_step?(:logo) }
  #validates :attachments, presence: true, if: -> { required_for_step?(:attachments) }
  
  def required_for_step?(step)
  	# All fields are required if no form step is present
    return true if form_step.nil?
    
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
