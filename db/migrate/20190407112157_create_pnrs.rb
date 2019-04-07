class CreatePnrs < ActiveRecord::Migration[5.2]
  def change
    create_table :pnrs do |t|
      t.integer :flight_id
      t.integer :seat_config_id

      t.timestamps
    end
  end
end
