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

      describe "with a valid Yoube link" do
        before do 
          fill_in "First name",   with: "Jhon" 
          fill_in "Link",         with: "https://www.youtube.com/watch?v=WpkDN78P884"
        end 

        it "create a story" do
          expect { click_button submit }.to change(Story, :count).by(1)
        end
      end

      describe "with an invalid Yoube link" do
        before do 
          fill_in "First name",   with: "Jhon" 
          fill_in "Link",         with: "https://www.youtube.com/sdsa"
          click_button submit
        end 

        it { should have_selector('div.alert.alert-danger') }
        it { should have_content('Link is invalid.') }
      end

    end
  end
end
