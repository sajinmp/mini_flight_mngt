# == Schema Information
#
# Table name: global_configs
#
#  id                :bigint(8)        not null, primary key
#  config_key        :string
#  config_value      :string
#  config_type       :string
#  configurable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class GlobalConfig < ApplicationRecord
  # Get config value
  def value
    case config_type
    when 'Integer'
      config_value.to_i
    when 'Float'
      config_value.to_f
    when 'Boolean'
      config_value == '1' || config_value.downcase == 'true'
    when 'Array'
      config_value.split(/\W+/)
    else
      config_value
    end
  end

  # Find a config with a key
  def self.with_key(key, configurable_type = nil)
    Rails.cache.fetch("global_config/#{key}/#{configurable_type}", expires_in: 4.hours) do
      @record = self.where(configurable_type: configurable_type) if configurable_type
      @record.find_by(config_key: key)&.value
    end
  end
end
