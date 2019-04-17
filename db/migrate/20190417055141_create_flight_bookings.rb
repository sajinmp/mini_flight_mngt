class CreateFlightBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_bookings do |t|
      t.integer :booking_id
      t.integer :flight_id
      t.text :seat_details

      t.timestamps
    end
  end
end
