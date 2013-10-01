class MoviesController < ApplicationController
	before_filter :require_login

	def index
		@movies = Movie.all(order: "title asc", include: [:created_by_id, :updated_by_id])
	end

	def show
		@movie = Movie.find(params[:id])
		@ratings = @movie.ratings.all(order: "created_at desc");
		@rating = @movie.ratings.build
	end

	def new
		@movie = Movie.new
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def create
		@movie = Movie.new(movie_params)
		if @movie.save
			redirect_to movies_path, notice: "Film hinzugefügt"
		else
			render "new"
		end
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			redirect_to movies_path, notice: "Film bearbeitet"
		else
			render "edit"
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path, notice: "Film gelöscht"
	end

	private

	def movie_params
	params.require(:movie).permit(:title, :quality_id, :three_dimensional, :information, :release_year).merge(editing_user: current_user)
	end
end