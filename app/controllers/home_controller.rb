require "will_paginate/array"

class HomeController < ApplicationController
	before_filter :require_login
	def index
		@status = current_user.statuses.build

		last_ratings = Rating.where("created_at > ?", Time.now - 3.months).includes([:movie, :user])
		movies_seen = SeenMovie.where("created_at > ?", Time.now - 3.months).includes([:movie, :user])
		last_statuses = Status.where("created_at > ?", Time.now - 3.months).includes(:user)
		last_wishes = Wish.where("created_at > ?", Time.now - 3.months).includes(:created_by_id)

		@last_activities = (last_ratings + movies_seen + last_statuses + last_wishes).sort{|b,a| a.created_at <=> b.created_at }.paginate(page: params[:page], per_page: 15)
	end
end