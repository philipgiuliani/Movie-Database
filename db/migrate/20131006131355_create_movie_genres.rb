class CreateMovieGenres < ActiveRecord::Migration
  def change
    create_table :movie_genres do |t|
      t.integer :movie_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
