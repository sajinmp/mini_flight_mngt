# == Schema Information
#
# Table name: bookings
#
#  id                  :bigint(8)        not null, primary key
#  amount              :float
#  no_of_seats         :string
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Booking < ApplicationRecord
  # Associations
  belongs_to :pnr
  belongs_to :flight
end
