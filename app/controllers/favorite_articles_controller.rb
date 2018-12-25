class FavoriteArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    current_user.favorite_articles.create(article_id: params[:article_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @favorite_article = FavoriteArticle.find_by(user_id: params[:id], article_id: params[:article_id])
    @favorite_article.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end
end
