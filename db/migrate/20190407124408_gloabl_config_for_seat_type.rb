class GloablConfigForSeatType < ActiveRecord::Migration[5.2]
  def change
    GlobalConfig.find_or_create_by(config_key: 'first', config_value: 1, config_type: 'Integer', configurable_type: 'seat_types')
    GlobalConfig.find_or_create_by(config_key: 'business', config_value: 2, config_type: 'Integer', configurable_type: 'seat_types')
    GlobalConfig.find_or_create_by(config_key: 'economy', config_value: 3, config_type: 'Integer', configurable_type: 'seat_types')
  end
end
