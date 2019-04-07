# == Schema Information
#
# Table name: pnrs
#
#  id         :bigint(8)        not null, primary key
#  seat_no    :string
#  flight_id  :integer
#  seat_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pnr < ApplicationRecord
end
