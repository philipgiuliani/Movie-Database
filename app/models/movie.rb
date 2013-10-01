class Movie < ActiveRecord::Base
  attr_accessor :editing_user

  belongs_to :quality
  belongs_to :created_by_id, :class_name => 'User', :foreign_key => 'created_by_id'
  belongs_to :updated_by_id, :class_name => 'User', :foreign_key => 'updated_by_id'
  has_many :ratings, dependent: :destroy
  has_many :seen_movies, dependent: :destroy

  before_create :before_create
  before_update :before_update

  validates :title, presence: true
  validates :editing_user, presence: true
  validates :quality, presence: true
  validates :release_year, presence: true, :length => { :is => 4 }, numericality: { only_integer: true }

  private

  def before_create 
    self.created_by_id = self.updated_by_id = editing_user
  end

  def before_update
    self.updated_by_id = editing_user
  end
end