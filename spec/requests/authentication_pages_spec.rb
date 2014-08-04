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
      it { should have_link("Settings", href: edit_user_url(user)) }
      it { should have_link("Sign out", href: signout_url) }
      it { should_not have_link("Sign in", href: signin_url) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
      
    end
  end
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_url(user) }
          it { should have_title("Sign in") }
        end
        
        describe "submitting to the update action" do
          before { put user_url(user) }
          specify { expect(response).to redirect_to(signin_url) }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in! user, no_capybara: true }
      
      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_url(wrong_user) }
        specify { expect(response.body).not_to match(full_title("Edit user")) }
        specify { expect(response).to redirect_to(root_url) }
      end
      
      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    
  end
  
end
