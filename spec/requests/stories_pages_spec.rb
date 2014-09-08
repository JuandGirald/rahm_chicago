require 'rails_helper'

RSpec.describe "Stories", :type => :request do
  describe "Stories pages" do
    subject { page }

    describe "create" do
      before { visit new_story_path }

      let(:submit) { "Create" }

      describe "with invalid information" do
        it "should not create a story" do
          expect { click_button submit }.not_to change(Story, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "First name",   with: "Todd"
          fill_in "Last name",    with: "Morril"
          fill_in "Email",        with: "todd@example.com"
          fill_in "Story body",   with: "This is a great story"
        end

        it "should create a story" do
          expect { click_button submit }.to change(Story, :count).by(1)
        end
      end
    end
  end
end
