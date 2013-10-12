class MoviesController < ApplicationController
	before_filter :require_login
	before_filter :require_admin, only: [:update, :edit, :destroy, :create, :new]

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
			flash[:success] = t("messages.new_movie")
			redirect_to movies_path
		else
			render "new"
		end
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			flash[:success] = t("messages.edit_movie")
			redirect_to movie_path(@movie)
		else
			render "edit"
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:success] = t("messages.delete_movie")
		redirect_to movies_path
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :subtitle, :quality_id, :three_dimensional, :length, :size, :information, :show_recommended, :release_year, :cover, :genre_ids => []).merge(editing_user: current_user)
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