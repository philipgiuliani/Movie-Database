require "factory_girl"

FactoryGirl.define do
	factory :user do
		sequence(:username) { |i| "username#{i}" }
		firstname "firstname"
		lastname "lastname"
		sequence(:email) { |i| "factory-#{i}@example.com" }
		password "test1234"
		password_confirmation "test1234"
	end
end