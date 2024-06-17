class CreateTaggings < ActiveRecord::Migration[7.1]
  def change
    create_table :taggings do |t|

      t.timestamps
    end
  end
end
