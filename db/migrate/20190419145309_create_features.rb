class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.boolean :automatic
      t.boolean :handwash
      t.boolean :touchless
      t.boolean :spray
      t.boolean :interior
      t.boolean :oil_change
      t.boolean :shampoo
      t.boolean :free_vacuum
      t.integer :washer_id

      t.timestamps
    end
  end
end
