require 'rails_helper'

RSpec.describe "Stories", :type => :request do
  describe "Stories pages" do
    subject { page }

    describe "create" do
      let(:submit) { "Create" }

      before do
        visit new_story_path

        fill_in "First name",     with: "Todd"
        fill_in "Last name",      with: "Morril"
        fill_in "Street address", with: "Brentwood"
        fill_in "City",           with: "Los Angeles"
        fill_in "State",          with: "California"
        fill_in "Email",          with: "todd@example.com"
        fill_in "Zip",            with: "90073"
      end

      describe "with valid information" do
        it "creates a story" do
          expect { click_button submit }.to change(Story, :count).by(1)
        end
      end

      describe "with invalid information" do
        before do
          fill_in "First name",   with: ""
          click_button submit
        end

        it { should have_selector('div.alert.alert-danger') }
        it { should have_content('First name (Please enter a valid First Name)') }

        it "not creates a story" do
          expect { click_button submit }.not_to change(Story, :count)
        end
      end

      describe "with a valid Yoube link" do
        before do 
          fill_in "Video link",   with: "https://www.youtube.com/watch?v=WpkDN78P884"
        end 

        it "create a story" do
          expect { click_button submit }.to change(Story, :count).by(1)
        end
      end

      describe "with an invalid Yoube link" do
        before do 
          fill_in "Video link",   with: "https://www.youtube.com/sdsa"
          click_button submit
        end 

        it { should have_selector('div.alert.alert-danger') }
        it { should have_content('Video link is invalid.') }
      end
    end
  end
end
