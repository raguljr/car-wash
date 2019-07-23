class ChangeRatingToIntInComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :rating, :int
  end
end
