require "factory_girl"

FactoryGirl.define do
	factory :vote do
		association :voteable, factory: :movie
		value 1
	end
end