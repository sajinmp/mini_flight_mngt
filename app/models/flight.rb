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

  # Validations
  validates_presence_of :origin, :destination

  # Callbacks
  after_create :create_pnrs
end
