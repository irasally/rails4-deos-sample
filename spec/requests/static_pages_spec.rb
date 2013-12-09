require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "shuld have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end
  describe "Help Page" do
    it "shuld have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end
end
