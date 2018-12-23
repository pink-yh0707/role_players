class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @articles = @user.articles.all
    end
  end
end
