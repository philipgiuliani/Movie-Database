class AddSizeAndLengthToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :size, :integer
    add_column :movies, :length, :integer
  end
end
