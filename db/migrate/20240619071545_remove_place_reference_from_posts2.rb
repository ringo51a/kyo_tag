class RemovePlaceReferenceFromPosts2 < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :place, null: false, foreign_key: true #マイグレーションファイルの名前は間違えたRemoveではなくAdd
  end
end
