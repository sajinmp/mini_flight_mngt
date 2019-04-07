# == Schema Information
#
# Table name: airlines
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Airline < ApplicationRecord
  # Associations
  has_many :seat_configs
  has_many :flights
end
