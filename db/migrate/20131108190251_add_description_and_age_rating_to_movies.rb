class AddDescriptionAndAgeRatingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :description, :text
    add_column :movies, :age_rating, :integer
  end
end
