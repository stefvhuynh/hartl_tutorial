require 'spec_helper'

describe "static pages" do
  subject { page }
  let(:title) { "Ruby on Rails Tutorial App" }

  describe "home page" do
    before { visit root_url }
    it { should have_content("Hartl Tutorial App") }
    it { should have_title(title) }
    it { should_not have_title("| Home") }
  end

  describe "help page" do
    before { visit help_url }
    it { should have_content("Help") }
    it { should have_title("#{title} | Help") }
  end

  describe "about page" do
    before { visit about_url }
    it { should have_content("About Us") }
    it { should have_title("#{title} | About Us") }
  end

  describe "contact page" do
    before { visit contact_url }
    it { should have_content("Contact") }
    it { should have_title("#{title} | Contact") }
  end

end