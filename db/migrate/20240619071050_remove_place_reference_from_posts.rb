class RemovePlaceReferenceFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :posts, :place, foreign_key: true
  end
end
