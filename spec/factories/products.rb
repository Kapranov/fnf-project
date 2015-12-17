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

FactoryGirl.define do
  factory :product do
    name "MyString"
  end

end
