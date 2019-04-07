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
end
