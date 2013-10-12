class HomeController < ApplicationController
	before_filter :require_login
	
	def index
		@current_user = current_user
		@last_ratings = Rating.all(order: "created_at desc", limit: "0,5", include: [:movie, :user])
		@movies_seen = SeenMovie.all(order: "created_at desc", limit: "0,5", include: [:movie, :user])
	end
end