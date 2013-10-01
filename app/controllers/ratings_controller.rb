class RatingsController < ApplicationController
	before_filter :require_login

	def create
    movie = Movie.find(params[:movie_id])
    @rating = movie.ratings.build(rating_params.merge({:user_id => current_user.id}));
    if @rating.save
			redirect_to movie_path(movie), notice: "Die Bewertung wurde erfolgreich gespeichert"
		else
			@movie = @rating.movie
      render 'movies/show'
		end
	end

	def edit
		@movie = Movie.find(params[:movie_id])
		@rating = @movie.ratings.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:movie_id])
		@rating = @movie.ratings.find(params[:id])

  	if @rating.update_attributes(rating_params)
      redirect_to movie_path(@movie), notice: "Bewertung bearbeitet"
  	else
  	  render "edit"
  	end
	end

	def destroy
		@movie = Movie.find(params[:movie_id])
		@rating = @movie.ratings.find(params[:id])
  	@rating.destroy
  	redirect_to movie_path(@movie), notice: "Bewertung gelöscht"
	end

	private

	def rating_params
		params.require(:rating).permit(:movie_id, :rating_general, :rating_quality, :comment)
	end
end