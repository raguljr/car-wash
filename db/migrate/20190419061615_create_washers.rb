class CreateWashers < ActiveRecord::Migration[5.2]
  def change
    create_table :washers do |t|
      t.string :name
      t.string :phone_number
      t.string :website
      t.string :primary_type
      t.string :secondary_type
      t.string :short_address

      t.timestamps
    end
  end
end
