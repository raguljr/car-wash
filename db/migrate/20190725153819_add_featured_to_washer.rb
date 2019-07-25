class AddFeaturedToWasher < ActiveRecord::Migration[5.2]
  def change
    add_column :washers, :featured, :boolean, default: false
  end
end
