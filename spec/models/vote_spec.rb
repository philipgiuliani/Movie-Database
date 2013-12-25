require "spec_helper"

describe Vote do

	let(:vote) { FactoryGirl.create(:vote) }

	it "has a valid factory" do
		vote.should be_valid
	end
	
end