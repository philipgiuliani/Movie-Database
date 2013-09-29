class Quality < ActiveRecord::Base
  has_many :movies

  validates :name, uniqueness: true, presence: true
end