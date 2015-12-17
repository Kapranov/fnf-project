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

FactoryGirl.define do
  factory :category do
    
  end

end
