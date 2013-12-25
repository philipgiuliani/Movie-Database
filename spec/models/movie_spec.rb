require "spec_helper"

describe Movie do

	let(:movie) { FactoryGirl.build(:movie) }

	it "has a valid factory" do
		movie.should be_valid
	end

end