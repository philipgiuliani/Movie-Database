require "factory_girl"

FactoryGirl.define do
	factory :quality do
		name "Schlecht (360p)"
		resolution_x 640
		resolution_y 360
	end
end