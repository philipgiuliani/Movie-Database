class Movie < ActiveRecord::Base
	attr_accessor :editing_user
	attr_accessor :cover

	has_attached_file :cover, styles: { big: "540x810>", medium: "300x450>", small: "100x150>" },
										url: "/assets/:attachment/:id/:style.:extension",
										path: ":rails_root/public/assets/:attachment/:id/:style.:extension"

	belongs_to :quality
	belongs_to :created_by_id, :class_name => 'User', :foreign_key => 'created_by_id'
	belongs_to :updated_by_id, :class_name => 'User', :foreign_key => 'updated_by_id'
	has_many :ratings, dependent: :destroy
	has_many :seen_movies, dependent: :destroy
	has_many :genres

	before_create :before_create
	before_update :before_update

	validates :title, presence: true
	validates :editing_user, presence: true
	validates :quality, presence: true
	validates :release_year, presence: true, :length => { :is => 4 }, numericality: { only_integer: true }
	validates :size, presence: true, numericality: { only_integer: true }
	validates :length, presence: true, numericality: { only_integer: true }
	validates_attachment :cover, presence: true, content_type: { content_type: ["image/jpeg", "image/png"] }, size: { in: 0..2.megabytes }

	def self.search(search)
		if search
			where("title LIKE ?", "%#{search}%")
		else
			scoped
		end
	end

	def rating_average_of(average_key)
		self.ratings.count > 0 ? (self.ratings.sum(average_key) / self.ratings.count) : 0
	end
	
	private

	def before_create 
		self.created_by_id = self.updated_by_id = editing_user
	end

	def before_update
		self.updated_by_id = editing_user
	end
end