class AddTitleToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :title, :string
    add_index :comments, [:ip_address, :washer_id], unique: true
  end
end
