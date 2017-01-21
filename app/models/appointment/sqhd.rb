# == Schema Information
#
# Table name: appointments
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  idname         :string(191)
#  type           :string(191)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  count          :integer
#  state          :integer
#  aptable_id     :integer
#  aptable_type   :string(191)
#  subdistrict_id :integer          default(1)
#
# Indexes
#
#  fk_rails_8e5577c7fd                                (subdistrict_id)
#  index_appointments_on_aptable_type_and_aptable_id  (aptable_type,aptable_id)
#  index_appointments_on_user_id                      (user_id)
#

# 社区活动预约
class Appointment::Sqhd < Appointment
  def self.model_name
    Appointment.model_name
  end

  def human_type
    "社区活动预约"
  end
end
