class CommentsController < ApplicationController
  
  load_and_authorize_resource

  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  # http_basic_authenticate_with name: "fahad", password: "password", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    flash[:error] = @comment.errors.full_messages[0]
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end