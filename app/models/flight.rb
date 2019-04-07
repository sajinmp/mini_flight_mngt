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
end
