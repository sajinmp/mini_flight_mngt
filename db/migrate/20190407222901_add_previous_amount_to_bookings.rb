class AddPreviousAmountToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :previous_amount, :float
  end
end
