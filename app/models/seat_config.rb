# == Schema Information
#
# Table name: seat_configs
#
#  id           :bigint(8)        not null, primary key
#  seat_type    :integer
#  no_of_rows   :integer
#  seats_in_row :integer
#  airline_id   :integer
#  base_price   :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SeatConfig < ApplicationRecord
end
