class CreatePnrsAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :pnrs do |t|
      t.integer :booking_id

      t.timestamps
    end
  end
end
