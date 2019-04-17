class CreatePassengerDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :passenger_details do |t|
      t.integer :flight_id
      t.integer :booking_id
      t.string :name
      t.string :seat_no
      t.integer :seat_config_id

      t.timestamps
    end
  end
end
