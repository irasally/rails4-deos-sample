require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home Page" do
    it "shuld have the content 'Sample App'" do
      visit root_path
      expect(page).to have_content('Sample App')
    end

    it "shuld have the title base title" do
      visit root_path
      expect(page).to have_title(base_title)
    end

    it "shuld not have a custom page title" do
      visit root_path
      expect(page).not_to have_title("| Home")
    end
  end

  describe "Help Page" do
    it "shuld have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "shuld have the title 'Help'" do
      visit help_path
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About Page" do
    it "shuld have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    it "shuld have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact Page" do
    it "shuld have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
    it "shuld have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end
