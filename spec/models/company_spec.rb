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

require 'rails_helper'

RSpec.describe Company, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
