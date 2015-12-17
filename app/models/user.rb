=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  post                   :string(255)
#  province               :string(255)
#  city                   :string(255)
#  role_id                :integer
#  status                 :string(255)      default("active")
#  note                   :text(65535)
#  about                  :text(65535)
#  avatar                 :string(255)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invitations_count     (invitations_count)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  include TheRole::Api::User
  # gem "socialization"
  acts_as_liker
  acts_as_follower
  acts_as_followable

  acts_as_mentioner # dlya favoritov
  

  # end
  # association
  has_one :company, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :trademarks, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  crop_uploaded :avatar  ## crop avatar

  # validation for steps registration and add company and others... trademark, product
  cattr_accessor :form_steps do
    %w(identity location about type_of_account)
  end

  attr_accessor :form_step

  # with_options if: -> { required_for_step?(:identity) } do |step|
  #   step.validates :first_name, presence: true
  #   step.validates :last_name, presence: true
  # end

  validates :first_name, :last_name, presence: true, if: -> { required_for_step?(:identity) }
  validates :province, :city, presence: true, if:  -> { required_for_step?(:characteristics) }
  validates :post, :about, :avatar, presence: true, if: -> { required_for_step?(:instructions) }
  validates :role, presence: true, if: -> { required_for_step?(:type_of_account) }
  
  def required_for_step?(step)
    return false if form_step.nil?
    return true if self.form_steps.index(step.to_s) && self.form_steps.index(form_step)
  end

  # validates :terms_of_service, acceptance: true, :message => '^Нужно принять соглашение'
  validates_acceptance_of :terms_of_service, :message => '^Нужно принять соглашение'
  # validates :role_id, inclusion: { in: %w(manufacturer distributor simple_customer),
  #   message: "%{value} is not a valid size" }

  #validates :email, presence: true, uniqueness: true
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # scope for customers
  scope :all_customers,    lambda { |roles_ids| where(:role_id => roles_ids) }
  #scope :all_customers,    ->(search) { where( role_id: Role.with_name(:manufacturer) or role_id: Role.with_name(:distributor) or role_id: Role.with_name(:simple_customer) ) }
  scope :manufacturers,    ->{ where(role_id: Role.with_name(:manufacturer)) }
  scope :distributors,     ->{ where(role_id: Role.with_name(:distributor)) }
  scope :simple_customers, ->{ where(role_id: Role.with_name(:simple_customer)) }
  # scope for search
  # scope :search,           ->(search) { where("first_name LIKE ? OR last_name like ?", "%#{search}%", "%#{search}%") }
  
  # scope for employees
  scope :all_employees,    lambda { |roles_ids| where(:role_id => roles_ids) }
  scope :administrators,   ->{ where(role_id: Role.with_name(:administrator)) }
  scope :moderators,       ->{ where(role_id: Role.with_name(:moderator)) }
  scope :operators,        ->{ where(role_id: Role.with_name(:operator)) }

  def name
    "#{first_name} #{last_name}"
  end

  # def admin?
  #   Role.with_name(:admin)
  # end

  # def administration? #fix me
  #   return true if Role.with_name(:admin)
  #   return true if Role.with_name(:moderator)  
  #   return true if Role.with_name(:operator)
  # end

  def role_name
    begin
      role.try(:name)
    rescue 
      nil
    end
    #role.try(:name)
  end
  def is_owner_of?(obj)
    return false unless obj
    # return true  if admin?

    section_name = obj.class.to_s.tableize
    # return true if moderator?(section_name)

    # obj is User, simple way to define user_id
    return id == obj.id if obj.is_a?(self.class)

    # few ways to define user_id
    return id == obj.user_id     if obj.respond_to? :user_id
    return id == obj[:user_id]   if obj[:user_id]
    return id == obj[:user][:id] if obj[:user]
  end
end