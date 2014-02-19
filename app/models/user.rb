class User < ActiveRecord::Base

	attr_accessor :avatar

	scope :newsletter_enabled, -> { where("newsletter = ?", true) }

	has_secure_password

	has_attached_file :avatar, styles: { big: "300x300>", medium: "160x160>", small: "100x100>" },
										url: "/assets/:attachment/:id/:style.:extension",
										path: ":rails_root/public/assets/:attachment/:id/:style.:extension",
										default_url: "/assets/:attachment/missing/:style.jpg"

	validates :username, presence: true, uniqueness: true, case_sensitive: false, format: { with: /\A[a-zA-Z0-9]+\Z/ }
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$\z/, uniqueness: true, presence: true
	validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/png"] }, size: { in: 0..2.megabytes }

	has_many :movies, foreign_key: "created_by_id"
	has_many :ratings, dependent: :destroy
	has_many :statuses, dependent: :destroy
	has_many :seen_movies, dependent: :destroy
	has_many :votes, dependent: :destroy
	
	def full_name
		"#{self.firstname} #{self.lastname}"
	end

	def is_admin?
		admin
	end

	def is_active?
		active
	end
	
	def has_seen?(movie)
		seen_movies.find_by_movie_id(movie).present?
	end

	def has_rated?(movie)
		ratings.find_by_movie_id(movie).present?
	end

	def has_voted?(object)
		votes.where("voteable_type = ? and voteable_id = ?", object.class, object.id).present?
	end

	def watched_genres
		ActiveRecord::Base.connection.exec_query("
			SELECT genres.id, genres.name, COUNT(movie_genres.genre_id) AS times_watched
			FROM seen_movies
			INNER JOIN movies ON seen_movies.movie_id = movies.id
			INNER JOIN movie_genres ON movie_genres.movie_id = seen_movies.movie_id
			INNER JOIN genres ON movie_genres.genre_id = genres.id
			WHERE seen_movies.user_id = #{self.id}
			GROUP BY seen_movies.user_id, movie_genres.genre_id HAVING times_watched > 0
			ORDER BY times_watched DESC").to_hash
	end

	def self.weekly_update
		movies = Movie.last_week.includes(:quality)
		User.newsletter_enabled.each do |user|
			UserMailer.weekly_movies_email(user, movies).deliver
		end
	end
end