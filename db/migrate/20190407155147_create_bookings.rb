class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :pnr_id
      t.integer :flight_id
      t.float :amount
      t.string :seat_no
      t.integer :status
      t.integer :upgraded_booking_id

      t.timestamps
    end

    GlobalConfig.find_or_create_by(config_key: 'booked', config_value: 1, config_type: 'Integer', configurable_type: 'booking_status')
    GlobalConfig.find_or_create_by(config_key: 'upgrade', config_value: 2, config_type: 'Integer', configurable_type: 'booking_status')
  end
end
