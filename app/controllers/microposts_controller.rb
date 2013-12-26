# -*- coding: utf-8 -*-
class MicropostsController < ApplicationController
  before_action :signed_in_user
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_itemd = [] #Postに失敗したときにFeedが表示されない問題の回避
      render 'static_pages/home'
    end
  end
  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
