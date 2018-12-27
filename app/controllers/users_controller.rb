class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.all
  end

  def following
    @title = "Following"
    @title_users = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @title_users = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render "show_follow"
  end
end
