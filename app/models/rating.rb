class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie

	validates :comment, presence: true, :length => { :minimum => 30 }
	validate :already_rated_this_movie, on: :create

	def rating_average
		(self.rating_general + self.rating_quality) / 2;
	end

	def already_rated_this_movie
		movie = Movie.find(self.movie_id)
		rating = movie.ratings.find_by_user_id(self.user_id)
    if rating
    	errors.add(:user, :already_rated)
    end
	end
end