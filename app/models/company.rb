=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
# == Schema Information
#
# Table name: companies
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  logo               :string(255)
#  name               :string(255)
#  description        :text(65535)
#  business_entity    :string(255)
#  vatcode            :string(255)
#  company_id_number  :string(255)
#  cea                :string(255)
#  registration_date  :date
#  juridical_country  :string(255)
#  juridical_province :string(255)
#  juridical_city     :string(255)
#  juridical_address  :string(255)
#  country            :string(255)
#  province           :string(255)
#  city               :string(255)
#  address            :string(255)
#  website            :string(255)
#  mobile             :string(255)
#  phone              :string(255)
#  fax                :string(255)
#  email              :string(255)
#  meta_title         :string(255)
#  meta_keywords      :string(255)
#  meta_description   :string(255)
#  state              :integer
#  type_company       :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#

require 'state_machine'

class Company < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  # after_create :change_state

  mount_uploader :logo, LogoUploader

  belongs_to :user

  has_many :products, dependent: :destroy
  has_many :trademarks, dependent: :destroy


  attr_accessor :state_event

  state_machine :state, initial: :pending do # автоматически сохраняет в поле state это состояние (в ожидании (:pending) )
    state :published, value: 0
    state :pending,   value: 1
    state :drafted,   value: 2
    state :denied,    value: 3
    state :trashed,   value: 4
    state :destroyed, value: 5
    # все состояния храняться в поле state, в числовом виде (integer)
    
    # events
    event :to_publish do
      transition all => :published
    end
     
    event :to_deny do
      transition pending: :denied
    end

    event :to_modify do
      transition pending: :drafted
    end
    
    event :to_trash do
      transition all - [:pending, :denied] => :trashed
    end
    event :to_success do 
      transition pending: :published
    end
    event :to_destroy do
      transition all - [:published, :denied, :trashed] => :destroyed
    end
  end

  #scopes, records for all type of companies
  scope :published, ->{ with_state(:published) }
  scope :pending,   ->{ with_state(:pending) }
  scope :editing,   ->{ with_state(:editing) }
  scope :denied,    ->{ with_state(:denied) }
  scope :trashed,   ->{ with_state(:trashed) }
  scope :removed,   ->{ with_state(:removed) }

  # scope for search
  # scope :search, ->(search) { where("name LIKE ?", "%#{search}%") }

  # scope :publisheds,    ->{ where(status: "pending") }
  # scope :pendings,    ->{ where(status: "pending") }
  # scope :deletings,    ->{ where(status: "pending") }
  # scope :pendings,    ->{ where(status: "pending") }

  # translates :name, :description, fallbacks_for_empty_translations: true    

  # validation for steps registration and add company and others... trademark, product
  cattr_accessor :form_steps do
    %w(information requisites seo logo)
  end

  attr_accessor :form_step

  with_options if: -> { required_for_step?(:information) } do |step|
    step.validates :name, length: {
      minimum: 3,
      maximum: 60,
      too_short: "^Название компании должно состоять по крайней мере из %{count} знаков",
      too_long: "^Название компании должно состоять не более чем из %{count} знаков"
    }
    step.validates :description, length: {
      minimum: 100,
      maximum: 2000,
      too_short: "^Описание компании должно состоять по крайней мере из %{count} знаков",
      too_long: "^Описание компании должно состоять не более чем из %{count} знаков"
    }
     
     
  end

  with_options if: -> { required_for_step?(:requisites) } do |step|
    step.validates :business_entity, presence: true
    step.validates :vatcode, presence: true
    step.validates :company_id_number, presence: true
    step.validates :cea, presence: true
    step.validates :registration_date, presence: true
  end

  with_options if: -> { required_for_step?(:seo) } do |step|
    # step.validates :meta_title, presence: true
    # step.validates :meta_description, presence: true
    #step.validates :meta_keywords, presence: true
    step.validates :meta_title, length: {
      minimum: 40,
      maximum: 60,
      too_short: "^Мета-заговолок должен состоять по крайней мере из %{count} знаков",
      too_long: "^Мета-заговолок должен состоять не более чем из %{count} знаков"
    }
    step.validates :meta_description, length: {
      minimum: 50,
      maximum: 160,
      too_short: "^Мета-описания должно состоять по крайней мере из %{count} знаков",
      too_long: "^Мета-описания должно состоять не более чем из %{count} знаков"
    }
  end


  with_options if: -> { required_for_step?(:logo) } do |step|
    step.validates :logo, presence: true
  end

  #validates :name, :description, presence: true, if: -> { required_for_step?(:information) }
  #validates :business_entity, :vatcode, :company_id_number, :cea, :registration_date, presence: true, if:  -> { required_for_step?(:requisites) }
  #validates :meta_title, :meta_description, :meta_keywords, presence: true, if: -> { required_for_step?(:seo) }
  #validates :logo, presence: true, if: -> { required_for_step?(:logo) }
  #validates :attachments, presence: true, if: -> { required_for_step?(:attachments) }
  
  def change_state
    self.to_publish
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return false if form_step.nil?
    
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
