class CreateWashers < ActiveRecord::Migration[5.2]
  def change
    create_table :washers do |t|
      t.string :name
      t.string :phone_number
      t.string :website
      t.string :primary_type
      t.string :secondary_type
      t.string :short_address
      t.string :city
      t.string :state
      t.string :state_code
      t.string :zip
      t.string :google_maps_url
      t.string :lat
      t.string :lon
      t.boolean :automatic
      t.boolean :handwash
      t.boolean :touchless
      t.boolean :spray
      t.boolean :interior
      t.boolean :oil_change
      t.boolean :shampoo
      t.boolean :free_vacuum
      t.string :sunday
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday

      t.timestamps
    end
  end
end
