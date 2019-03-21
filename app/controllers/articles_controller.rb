class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.page(params[:page]).per(10)
      .includes(:user, :player, :favorites).search(params[:search])
  end

  def show
    @article = Article.find(params[:id])
    @comment = current_user.comments.build if user_signed_in?
  end

  def new
    @article = Article.new
    @article.build_player
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "記事を作成しました。"
      redirect_to @article
    else
      render "new"
    end
  end

  def edit
    @article.player = Player.new if @article.player.blank?
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "記事を更新しました。"
      redirect_to article_path
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "記事を削除しました。"
    redirect_to root_url
  end

  def favorite_order
    @articles = Article.page(params[:page]).per(10)
      .includes(:user, :player, :favorites).favorite_sort
    render "index"
  end

  def release
    article = Article.find(params[:id])
    article.released! if !article.released?
    flash[:success] = "記事を公開しました。"
    redirect_to article_path
  end

  def private
    article = Article.find(params[:id])
    article.privated! if !article.privated?
    flash[:success] = "記事を非公開にしました"
    redirect_to article_path
  end

  private
    def article_params
      params.require(:article).permit(
        :article_title, :content, :article_image, :status,
        player_attributes: [
          :player_name, :team_name, :country, :position,
          :height, :weight
        ]
      )
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
end
