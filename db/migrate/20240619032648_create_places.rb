class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :place_id, null: false

      t.timestamps
    end
    add_index :places, :place_id, unique: true
  end
end
