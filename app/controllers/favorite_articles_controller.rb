class FavoriteArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.favorite_articles.create(article_id: params[:article_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.json
    end
  end

  def destroy
    @favorite_article = FavoriteArticle.find_by(user_id: params[:id], article_id: params[:article_id])
    @favorite_article.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.json
    end
  end
end
