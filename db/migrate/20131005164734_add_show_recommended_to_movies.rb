class AddShowRecommendedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :show_recommended, :boolean
  end
end
