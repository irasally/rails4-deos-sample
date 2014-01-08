require 'spec_helper'

describe "MicropostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost pagenation" do
    before do
      # FIXME
      50.times{ FactoryGirl.create(:micropost, user: user) }
      visit root_path
    end
    after do
      #FIXME
      user.feed.delete_all
    end
    it { should have_selector('div.pagination') }
    it "should list each microposts" do
      user.feed.paginate(page:1).each do |feed|
        expect(page).to have_selector("li##{feed.id}")
      end
    end
  end

  describe "micropost contents wrapping" do
    before do
      FactoryGirl.create(:micropost, user: user, content: 'Lorem ipsum dolor sit amet')
      FactoryGirl.create(:micropost, user: user, content: 'Longggggggggggggggggggggggggggcontenttttttttttttttttttttttttwraaaaaaaaaaap')
      visit root_path
    end
    after do
      #FIXME
      user.feed.delete_all
    end
    it { should have_selector('span.content', text: 'Lorem ipsum dolor sit amet') }
    it { should_not have_selector('span.content', text: 'Longggggggggggggggggggggggggggcontenttttttttttttttttttttttttwraaaaaaaaaaap') }
    it { should have_selector('span.content', text: 'Longgggggggggggggggggggggggggg') }
    it { should have_selector('span.content', text: 'contentttttttttttttttttttttttt') }
    it { should have_selector('span.content', text: 'wraaaaaaaaaaap') }
  end
end

describe "micropost left charactors counter", :js => true do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    visit root_path
  end
  it { should have_selector('#counter', text:'140')}

  describe "should decrease when input contents" do
    before do
      fill_in 'micropost_content', with: 'abcde'
    end
    it{ should_not have_selector('#counter', text:'140') }
    it{ should have_selector('#counter', text:'135') }
  end
end
