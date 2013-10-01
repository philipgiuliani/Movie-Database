class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :rating_general
      t.integer :rating_quality
      t.text :comment

      t.timestamps
    end
  end
end
