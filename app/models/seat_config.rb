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
  belongs_to :airline
  has_one :seat_type_config, -> { where(configurable_type: 'seat_types') }, class_name: 'GlobalConfig', primary_key: :seat_type, foreign_key: :config_value
end
