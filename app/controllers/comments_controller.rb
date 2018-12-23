class CommentsController < ApplicationController
  # before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.article_id = params[:comment][:id]
    if @comment.save
      flash[:success] = "コメントしました。"
      redirect_to article_path(params[:comment][:id])
    else
      redirect_to article_path(params[:comment][:id])
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
