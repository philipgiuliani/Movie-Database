class MoviesController < ApplicationController
	
	before_filter :require_login
	before_filter :require_admin, only: [:update, :edit, :destroy, :create, :new, :api_search_movie]

	def index
		@movies = Movie.search(params[:search]).order(sort_column).paginate(per_page: 20, page: params[:page])
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
			redirect_to movie_path(@movie), notice: t("messages.new_movie")
		else
			render "new"
		end
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			redirect_to movie_path(@movie), notice: t("messages.edit_movie")
		else
			render "edit"
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path, notice: t("messages.delete_movie")
	end

	def api_search_movie
		service = MovieDatabaseAPIService.new(api_key: "777819116e63a4620e70c4ea31f00333")
		movie = service.search_movie(params[:name], params[:release_year])
		if service.errors.empty?
			render json: movie
		else
			render json: { errors: service.errors }, status: :unprocessable_entity
		end
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :quality_id, :age_rating, :description, :three_dimensional, :length, :size, :release_year, :cover, :genre_ids => []).merge(editing_user: current_user)
	end

	def sort_column
		params[:sort] || "title"
		case params[:sort]
			when "title"
				"title asc"
			when "new"
				"created_at desc"
			else
				"title asc"
		end
	end
end