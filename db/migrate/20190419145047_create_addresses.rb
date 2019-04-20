class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :state_code
      t.string :zip
      t.string :google_maps_url
      t.string :lat
      t.string :lon
      t.integer :washer_id

      t.timestamps
    end
  end
end
