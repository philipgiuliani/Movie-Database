class MoviesController < ApplicationController
	before_filter :require_login

	def index
		@movies = Movie.search(params[:search]).order("title asc").includes([:created_by_id, :updated_by_id]).paginate(per_page: 20, page: params[:page])
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
			redirect_to movies_path, notice: t("messages.new_movie")
		else
			render "new"
		end
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			redirect_to movies_path, notice: t("messages.edit_movie")
		else
			render "edit"
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path, notice: t("messages.delete_movie")
	end

	private

	def movie_params
	params.require(:movie).permit(:title, :subtitle, :quality_id, :three_dimensional, :length, :size, :information, :show_recommended, :release_year, :cover).merge(editing_user: current_user)
	end
end