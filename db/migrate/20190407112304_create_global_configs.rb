class CreateGlobalConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :global_configs do |t|
      t.string :config_key
      t.string :config_value
      t.string :config_type
      t.string :configurable_type

      t.timestamps
    end
  end
end
