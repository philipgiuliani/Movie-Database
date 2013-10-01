class SeenMoviesController < ApplicationController
	before_filter :require_login

	def update
  	@movie = Movie.find(params[:movie_id])
		if current_user.has_seen?(@movie)
			current_user.seen_movies.destroy(current_user.seen_movies.find_by_movie_id(@movie))
			redirect_to movie_path(@movie), notice: "Der Film wurde als ungesehen markiert"
		else
			current_user.seen_movies.create(movie_id: @movie.id)
			redirect_to movie_path(@movie), notice: "Der Film wurde als gesehen markiert"
		end
	end
end