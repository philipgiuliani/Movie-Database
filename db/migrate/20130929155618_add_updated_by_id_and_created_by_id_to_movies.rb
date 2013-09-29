class AddUpdatedByIdAndCreatedByIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :created_by_id, :integer
    add_column :movies, :updated_by_id, :integer
  end
end