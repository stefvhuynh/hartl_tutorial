require 'spec_helper'

describe "user pages" do
  subject { page }

  describe "sign up page" do
    before { visit signup_url }
    it { should have_content("Sign up") }
    it { should have_title(full_title("Sign up"))}
    
    describe "sign up" do
      before { visit signup_url }
      let(:submit_button) { "Create my account" }
    
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit_button }.not_to change(User, :count)
        end
      
        describe "after submission" do
          before { click_button submit_button }
          it { should have_title("Sign up") }
          it { should have_content("error") }
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
        
        describe "after saving the user" do
          before { click_button submit_button }
          let(:user) { User.find_by_email("user@example.com") }
      
          it { should have_link("Sign out") }
          it { should have_title(user.name) }
          it { should have_selector("div.alert.alert-success") }
        end
      end
    end
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_url(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end
