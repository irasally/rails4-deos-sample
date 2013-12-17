# -*- coding: utf-8 -*-
前提(/^サインインページを表示している$/) do
  visit signin_path
end

前提(/^ユーザは登録済みである$/) do
  @user = User.create(name: 'test', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')
end

もし(/^何も入力せずにログインボタンを押す$/) do
  sign_in
end

ならば(/^エラーメッセージが表示される$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

もし(/^存在しないユーザ情報を入力してログインボタンを押す$/) do
  fill_in "Email", with: 'Hogehoge@example.com'
  fill_in "Password", with: 'Papapapapa'
  sign_in
end

もし(/^存在するユーザ情報を入力してログインボタンを押す$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  sign_in
end

ならば(/^プロフィールページが表示される$/) do
  expect(page).to have_title(@user.name)
end

ならば(/^サインアウトのリンクが存在する$/) do
  expect(page).to have_link('Sign out', href: signout_path)
end

def sign_in
  click_button "Sign in"
end
