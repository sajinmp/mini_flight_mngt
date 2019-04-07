class CreatePnrs < ActiveRecord::Migration[5.2]
  def change
    create_table :pnrs do |t|
      t.string :pnr_no
      t.integer :flight_id
      t.integer :seat_type

      t.timestamps
    end
  end
end
