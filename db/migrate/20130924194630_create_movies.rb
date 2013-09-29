class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :quality_id
      t.boolean :three_dimensional
      t.text :information

      t.timestamps
    end
  end
end
