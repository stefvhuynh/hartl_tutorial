require 'spec_helper'

describe "Authentication" do 
  subject { page }
  
  describe "sign-in page" do
    before { visit signin_url }
    
    it { should have_content("Sign in") }
    it { should have_title("Sign in") }
    
    describe "with invalid credentials" do
      before { click_button "Sign in" }
      it { should have_selector("div.alert.alert-errors") }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector("div.alert.alert-errors") }
      end
    end
    
    describe "with valid credentials" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      
      it { should have_title(user.name) }
      it { should have_link("Profile", href: user_url(user)) }
      it { should have_link("Sign out", href: signout_url) }
      it { should_not have_link("Sign in", href: signin_url) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
      
    end
  end
end
