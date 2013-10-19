class Wish < ActiveRecord::Base
	attr_accessor :editing_user

	before_create :before_create
	before_update :before_update

	belongs_to :created_by_id, class_name: 'User', foreign_key: 'created_by_id'
	belongs_to :updated_by_id, class_name: 'User', foreign_key: 'updated_by_id'

	validates :movie_title, presence: true, length: { minimum: 5 }
	validates :editing_user, presence: true
	validates :priority, presence: true
	validates :status, presence: true
	validates :movie_id, numericality: { only_integer: true }, allow_nil: true

	private

	def before_create 
		self.created_by_id = self.updated_by_id = editing_user
	end

	def before_update
		self.updated_by_id = editing_user
	end
end