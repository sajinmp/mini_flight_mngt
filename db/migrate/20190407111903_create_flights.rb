class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.integer :airline_id
      t.string :origin
      t.string :destination

      t.timestamps
    end
  end
end
