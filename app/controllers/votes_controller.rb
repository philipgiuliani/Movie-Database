class VotesController < ApplicationController
	before_filter :require_login

	def vote
		@movie = Movie.find(params[:movie_id])
		if current_user.has_voted?(@movie)
			vote = @movie.votes.where(user_id: current_user.id).first
			puts vote.inspect
			puts params[:value]
			puts vote.value
			if params[:value].to_i != vote.value
				puts "UPDATE"
				vote.update_attributes!(value: params[:value])
			else
				puts "DESTROY"
				vote.destroy!
			end
		else
			@movie.votes.create(user_id: current_user.id, value: params[:value])
		end
		render partial: "movies/vote_button"
	end

end