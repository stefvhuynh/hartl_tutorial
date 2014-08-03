require 'spec_helper'

describe "static pages" do
  let(:title) { "Ruby on Rails Tutorial App |" }

  describe "home page" do
    it "should have the content 'Hartl Tutorial App'" do
      visit "/static_pages/home"
      expect(page).to have_content("Hartl Tutorial App")
    end

    it "should have the right title 'Home'" do
      visit "/static_pages/home"
      expect(page).to have_title("#{title} Home")
    end
  end

  describe "help page" do
    it "should have the content 'Help'" do
      visit "/static_pages/help"
      expect(page).to have_content("Help")
    end

    it "should have the right title 'Help'" do
      visit "/static_pages/help"
      expect(page).to have_title("#{title} Help")
    end
  end

  describe "about page" do
    it "should have the content 'About Us'" do
      visit "/static_pages/about"
      expect(page).to have_content("About Us")
    end

    it "should have the right title 'About Us'" do
      visit "/static_pages/about"
      expect(page).to have_title("#{title} About Us")
    end
  end

end