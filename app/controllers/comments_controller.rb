class CommentsController < ApplicationController

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
    @user = User.find(@article.user_id)
    if @user.id == current_user.id then
        @comment.destroy
    end
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end