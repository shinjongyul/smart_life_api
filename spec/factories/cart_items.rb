# == Schema Information
#
# Table name: cart_items
#
#  id             :integer          not null, primary key
#  product_id     :integer
#  user_id        :integer
#  count          :integer
#  amount         :float
#  state          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :integer
#  subdistrict_id :integer
#  product_title  :string
#
# Indexes
#
#  index_cart_items_on_order_id    (order_id)
#  index_cart_items_on_product_id  (product_id)
#  index_cart_items_on_user_id     (user_id)
#

FactoryGirl.define do
  factory :cart_item do
    product_id 1
    count 3
  end
end
