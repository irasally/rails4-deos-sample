# -*- coding: utf-8 -*-
前提(/^サインインページを表示している$/) do
  visit signin_path
end
もし(/^何も入力せずにログインボタンを押す$/) do
  click_button "Sign in"
end

ならば(/^エラーメッセージが表示される$/) do
  expect(page).to have_selector('div.alert.alert-error')
end
