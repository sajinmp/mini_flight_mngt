# == Schema Information
#
# Table name: bookings
#
#  id                  :bigint(8)        not null, primary key
#  pnr_id              :integer
#  flight_id           :integer
#  amount              :float
#  seat_no             :string
#  status              :integer
#  upgraded_booking_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Booking < ApplicationRecord
  # Associations
  belongs_to :pnr
  belongs_to :flight
end
