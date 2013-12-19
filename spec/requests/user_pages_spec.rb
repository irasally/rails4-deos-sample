# -*- coding: utf-8 -*-
require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@exaample.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@exaample.com")
      visit users_path
    end
    it { should have_title('All users') }
    it { should have_content('All users') }
    it "should list wach user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit){ "Create my account" }

    describe "page" do
      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up'))}
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect{ click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before {click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
        it { should have_error_message('The form contains 5 errors.') }
        it { should have_text('* Password can\'t be blank') }
        it { should have_text('* Password is too short (minimum is 6 characters)') }
        it { should have_text('* Name can\'t be blank') }
        it { should have_text('* Email can\'t be blank')  }
        it { should have_text('* Email is invalid') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end
      it "should create a user" do
        expect{ click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before {click_button submit }
        let(:user) { User.find_by(email: 'user@example.com')}
        it { should have_link('Sign out', href: signout_path) }
        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user){ FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
     it { should have_content("Update your profile") }
     it { should have_title("Edit user") }
     it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end
      it { should have_title(new_name) }
      it { should have_success_message('Profile updated') }
      # 未ログイン状態 TODO  it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
