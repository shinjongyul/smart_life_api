# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  phone      :string
#  conmunity  :string
#  address    :string
#  is_default :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contacts_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :contact do
    name "contact name"
    phone "contact phone"
    conmunity "contact conmunity"
    address "contact address"
    is_default false
  end
end