class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.float :rating
      t.text :comment
      t.string :ip_address
      t.references :washer, foreign_key: true

      t.timestamps
    end
  end
end
