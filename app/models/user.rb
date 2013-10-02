class User < ActiveRecord::Base
	attr_accessor :avatar

	has_secure_password
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
										url: "/assets/:attachment/:id/:style.:extension",
										path: ":rails_root/public/assets/:attachment/:id/:style.:extension"

	validates :username, uniqueness: true, presence: true
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates_attachment :avatar, presence: true, content_type: { content_type: ["image/jpeg", "image/png"] }, size: { in: 0..2.megabytes }

	has_many :movies, :foreign_key => 'created_by_id'
	has_many :ratings, dependent: :destroy
	has_many :seen_movies, dependent: :destroy
	
	def full_name
		"#{self.firstname} #{self.lastname}"
	end

	def has_seen?(movie)
		seen_movies.find_by_movie_id(movie).present?
	end
end