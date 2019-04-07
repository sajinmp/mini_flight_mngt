class CreateSeatConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :seat_configs do |t|
      t.integer :seat_type
      t.integer :no_of_rows
      t.integer :seats_in_row
      t.integer :airline_id
      t.float :base_price

      t.timestamps
    end
  end
end
