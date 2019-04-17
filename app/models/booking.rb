# == Schema Information
#
# Table name: bookings
#
#  id          :bigint(8)        not null, primary key
#  no_of_seats :integer
#  amount      :float
#  status      :integer
#  origin      :string
#  destination :string
#

class Booking < ApplicationRecord
  # Associations
  has_many :flight_bookings
  has_one :pnr
end
