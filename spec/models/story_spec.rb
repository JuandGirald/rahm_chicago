require 'rails_helper'

describe Story do

  before { @story = FactoryGirl.create(:story, first_name: 'Todd') }

  subject { @story }

  it { should respond_to(:first_name) }

  it { should be_valid }

  describe "when first name is not present" do
    before { @story.first_name = " " }
    it { should_not be_valid }
  end
end
