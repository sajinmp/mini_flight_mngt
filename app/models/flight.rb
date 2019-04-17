# == Schema Information
#
# Table name: flights
#
#  id          :bigint(8)        not null, primary key
#  airline_id  :integer
#  origin      :string
#  destination :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Flight < ApplicationRecord
  include Concerns::FlightConcerns

  # Associations
  belongs_to :airline
  has_many :pnrs
  has_many :seat_configs, through: :airline
  has_many :bookings
  has_many :flight_bookings

  # Validations
  validates_presence_of :origin, :destination

  # Callbacks
  # after_create :create_pnrs

  # Scopes
  scope :join_flights, -> { joins('left join flights b on b.origin = flights.destination') }
  scope :flights_with_origin_destination, ->(origin, destination) {where(origin: origin, destination: destination) }
  scope :connected_flights, ->(origin, destination) { where('flights.origin = ? and b.destination = ?', origin, destination) }
  scope :select_connected_flight_details, -> { select('flights.id as id, b.id as connection_id, flights.origin as origin,
          flights.destination as connection_point, b.destination as destination') }
end
