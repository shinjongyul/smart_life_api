# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  title      :string(191)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Banner, type: :model do

end
