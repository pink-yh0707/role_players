class UsersController < ApplicationController
  # deviseでログインしていない場合new_user_session_pathへ遷移する
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.all
  end
end
