class LikesController < ApplicationController

  def dislike
    @article = Article.find(params[:id])
    @like = @article.likes.find_by_user_id(current_user.id)
    @like.destroy
    redirect_to article_path(@article)
  end

  def like
    puts "LIKE"
    @article = Article.find(params[:id])
    @like = @article.likes.create(like_params)
    redirect_to article_path(@article)
  end

  private
  def like_params
    params[:user_id] = current_user.id
    params[:article_id] = params[:id]
    params.permit(:article_id, :user_id)
  end

end