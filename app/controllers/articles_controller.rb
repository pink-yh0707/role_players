class ArticlesController < ApplicationController
  def index
    @articles = Article.all.includes(:player)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to current_user
      flash[:success] = "記事を作成しました。"
    else
      render "new"
    end
  end

  private
    def article_params
      params.require(:article).permit(
        :article_title, :content, :article_image,
        player_attributes: [
          :player_name, :team_name, :country, :position,
          :height, :weight
        ]
      )
    end
end
