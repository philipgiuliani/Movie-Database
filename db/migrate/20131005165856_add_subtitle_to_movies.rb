class AddSubtitleToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :subtitle, :string
  end
end
