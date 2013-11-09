class RemoveSubtitleAndInformationFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :subtitle, :string
    remove_column :movies, :information, :text
  end
end
