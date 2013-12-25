require "factory_girl"

FactoryGirl.define do
	factory :movie do
		title "Testmovie"
		association :editing_user, factory: :user
		release_year 2013
		size 4500
		length 120
		cover File.new("#{Rails.root}/spec/fixtures/cover.png")
		quality
	end
end