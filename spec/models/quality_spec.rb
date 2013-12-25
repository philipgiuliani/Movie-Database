require "spec_helper"

describe Quality do

	let(:quality) { FactoryGirl.build(:quality) }

	it "has a valid factory" do
		quality.should be_valid
	end

end