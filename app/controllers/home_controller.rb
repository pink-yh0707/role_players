class HomeController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @articles = @user.articles.all
  end
end
