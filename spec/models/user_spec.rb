require "spec_helper"

describe User do

	let(:user) { FactoryGirl.create(:user) }

	it "has a valid factory" do
		user.should be_valid
	end

	describe "#has_voted?" do
		let(:movie) { FactoryGirl.create(:movie) }

		it "returns false if the user has not voted" do
			user.has_voted?(movie).should eq(false)
		end

		it "returns true if the user has voted" do
			movie.votes.create(user: user, value: 1)
			user.has_voted?(movie).should eq(true)
		end
	end
end