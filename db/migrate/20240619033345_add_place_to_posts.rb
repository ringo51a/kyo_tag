class AddPlaceToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :place, null: false, foreign_key: true
  end
end
