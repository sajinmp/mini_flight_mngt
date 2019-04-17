# == Schema Information
#
# Table name: passenger_details
#
#  id             :bigint(8)        not null, primary key
#  flight_id      :integer
#  booking_id     :integer
#  name           :string
#  seat_no        :string
#  seat_config_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PassengerDetail < ApplicationRecord
  belongs_to :seat_config
  belongs_to :flight
  belongs_to :booking
end
