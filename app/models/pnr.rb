# == Schema Information
#
# Table name: pnrs
#
#  id             :bigint(8)        not null, primary key
#  flight_id      :integer
#  seat_config_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Pnr < ApplicationRecord
  # Associations
  belongs_to :flight
  belongs_to :seat_config
  has_one :confirmed_booking, -> { where(status: GlobalConfig.with_key('booked', 'booking_status')) }, class_name: 'Booking'
  has_many :bookings
end
