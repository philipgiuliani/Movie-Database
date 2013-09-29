class User < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_many :movies

  def full_name
    "#{self.firstname} #{self.lastname}"
  end
end