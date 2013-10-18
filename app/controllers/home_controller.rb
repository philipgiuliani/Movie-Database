class HomeController < ApplicationController
	before_filter :require_login
	
	def index
		@status = current_user.statuses.build

		last_ratings = Rating.all(order: "created_at desc", limit: "0,15", include: [:movie, :user])
		movies_seen = SeenMovie.all(order: "created_at desc", limit: "0,15", include: [:movie, :user])
		last_statuses = Status.all(order: "created_at desc", limit: "0,15", include: [:user])
		@last_activities = (last_ratings + movies_seen + last_statuses).sort{|b,a| a.created_at <=> b.created_at }[0..14]
	end
end