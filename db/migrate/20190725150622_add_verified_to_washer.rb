class AddVerifiedToWasher < ActiveRecord::Migration[5.2]
  def change
    add_column :washers, :verified, :boolean, default: false
  end
end
