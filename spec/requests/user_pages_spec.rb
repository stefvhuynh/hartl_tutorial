require 'spec_helper'

describe "user pages" do
  subject { page }

  describe "sign up page" do
    before { visit signup_url }
    it { should have_content("Sign up") }
    it { should have_title(full_title("Sign up"))}
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_url(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  
  describe "sign up" do
    before { visit signup_url }
    let(:submit_button) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit_button }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit_button }.to change(User, :count).by(1)
      end
    end
  end

end
