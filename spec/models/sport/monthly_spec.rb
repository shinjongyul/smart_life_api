# == Schema Information
#
# Table name: sport_monthlies
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  count      :integer
#  year       :integer
#  month      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sport_monthlies_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Sport::Monthly, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
