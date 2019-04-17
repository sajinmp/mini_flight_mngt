class CreateBookingsAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :no_of_seats
      t.float :amount
      t.integer :status
      t.string :origin
      t.string :destination
    end
  end
end
