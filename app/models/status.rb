class Status < ActiveRecord::Base
	belongs_to :user
	validates :comment, presence: true, :length => { :minimum => 5 }
end