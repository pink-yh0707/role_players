class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @articles = @user.articles.page(params[:page]).per(5).includes(:player, :favorites)
    end
  end
end
