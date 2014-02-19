class RemoveShowRecommendedFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :show_recommended, :boolean
  end
end
