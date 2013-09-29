class AddReleaseYearToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :release_year, :integer
  end
end
