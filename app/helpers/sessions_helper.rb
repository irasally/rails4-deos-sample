# -*- coding: utf-8 -*-
module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  def sign_out
    cookies.delete(:remember_token);
    @current_user = nil
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
  def signed_out_user
    redirect_to root_path if signed_in?
  end
  def current_user?(user)
    user == current_user
  end
  def signed_in?
    !current_user.nil?
  end
  def redirect_back_or(default)
    # セッションにurlが保存されていればそのurlにresirectする
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def store_location
    # 現在のurlをセッションに保存
    session[:return_to] = request.url
  end
end
