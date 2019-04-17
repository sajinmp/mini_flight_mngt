# == Schema Information
#
# Table name: flight_bookings
#
#  id           :bigint(8)        not null, primary key
#  booking_id   :integer
#  flight_id    :integer
#  seat_details :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FlightBooking < ApplicationRecord
end
