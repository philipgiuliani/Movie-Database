class User < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

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