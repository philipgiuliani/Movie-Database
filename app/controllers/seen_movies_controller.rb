class SeenMoviesController < ApplicationController
	before_filter :require_login

	def toggle_status
		@movie = Movie.find(params[:movie_id])
		if current_user.has_seen?(@movie)
			current_user.seen_movies.destroy(current_user.seen_movies.find_by_movie_id(@movie))
			render :partial => 'movies/toggle_button'
		else
			current_user.seen_movies.create(movie_id: @movie.id)
			render :partial => 'movies/toggle_button'
		end
	end
end