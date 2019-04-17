# == Schema Information
#
# Table name: pnrs
#
#  id         :bigint(8)        not null, primary key
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pnr < ApplicationRecord
  # Associations
  belongs_to :booking
end
