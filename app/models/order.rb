# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  token              :string(255)
#  status             :string(255)
#  received_at        :datetime
#  accepted_at        :datetime
#  shipped_at         :datetime
#  consignment_number :string(255)
#  rejected_at        :datetime
#  rejected_by        :integer
#  ip_address         :string(255)
#  notes              :text(65535)
#  exported           :boolean          default(FALSE)
#  invoice_number     :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_orders_on_received_at  (received_at)
#  index_orders_on_token        (token)
#

=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Order < ActiveRecord::Base
  # Orders can have properties
  #key_value_store :properties

  # Require dependencies
  require_dependency 'order/states'
  require_dependency 'order/actions'
  require_dependency 'order/billing'

  # All items which make up this order
  has_many :order_items, :dependent => :destroy,  :inverse_of => :order
  accepts_nested_attributes_for :order_items, :allow_destroy => true, :reject_if => Proc.new { |a| a['ordered_item_id'].blank? }

  # All products which are part of this order (accessed through the items)
  has_many :products, :through => :order_items, :source => :ordered_item, :source_type => 'Product'

  # The order can belong to a user
  belongs_to :user
  # has_many :addresses, :through => :customers 

  # Validations
  validates :token, :presence => true
  with_options :if => Proc.new { |o| !o.building? } do |order|
    order.validates :email_address, :format => {:with => /\A\b[A-Z0-9\.\_\%\-\+]+@(?:[A-Z0-9\-]+\.)+[A-Z]{2,6}\b\z/i}
    order.validates :phone_number, :format => {:with => /\A[+?\d\ \-x\(\)]{7,}\z/}
  end

  # Set some defaults
  before_validation { self.token = SecureRandom.uuid  if self.token.blank? }

  # Some methods for setting the billing & delivery addresses
  attr_accessor :save_addresses, :billing_address_id, :delivery_address_id

  # The order number
  #
  # @return [String] - the order number padded with at least 5 zeros
  def number
    id ? id.to_s.rjust(6, '0') : nil
  end

  # The length of time the customer spent building the order before submitting it to us.
  # The time from first item in basket to received.
  #
  # @return [Float] - the length of time
  def build_time
    return nil if self.received_at.blank?
    self.created_at - self.received_at
  end

  # The name of the customer in the format of "Company (First Last)" or if they don't have
  # company specified, just "First Last".
  #
  # @return [String]
  def customer_name
    company.blank? ? full_name : "#{company} (#{full_name})"
  end

  # The full name of the customer created by concatinting the first & last name
  #
  # @return [String]
  def full_name
    "#{first_name} #{last_name}"
  end

  # Is this order empty? (i.e. doesn't have any items associated with it)
  #
  # @return [Boolean]
  def empty?
    order_items.empty?
  end

  # Does this order have items?
  #
  # @return [Boolean]
  def has_items?
    total_items > 0
  end

  # Return the number of items in the order?
  #
  # @return [Integer]
  def total_items
    order_items.inject(0) { |t,i| t + i.quantity }
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "billing_postcode", "billing_address1", "billing_address2", "billing_address3", "billing_address4", "first_name", "last_name", "company", "email_address", "phone_number", "consignment_number", "status", "received_at"] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end
 
