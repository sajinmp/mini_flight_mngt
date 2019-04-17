class DropTablePnrsAndBooking < ActiveRecord::Migration[5.2]
  def change
    drop_table :pnrs
    drop_table :bookings
  end
end
