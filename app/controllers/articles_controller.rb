class ArticlesController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index, :like, :dislike]
  load_and_authorize_resource :except => [:show, :index, :like, :dislike]
  skip_load_resource :only => [:create]

  # http_basic_authenticate_with name: "fahad", password: "password", except: [:index, :show]

  def new
  end

  def index
    @articles = Article.all
    #@users = User.all
  end

  def edit
    @article = Article.find(params[:id])
    #  if current_user.id != @article.user_id then
    #    redirect_to articles_path
    #  else
    @article = Article.find(params[:id])
    #  end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      flash.now[:error] = @article.errors.full_messages[0]
      render 'edit'
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      flash.now[:error] = @article.errors.full_messages[0]
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    #  if @article.user_id != current_user.id then
    #    redirect_to articles_path
    #  else
    @article.destroy
    redirect_to articles_path
    #  end
  end

  def show
    @article = Article.find(params[:id])
  end

  def dislike
    @article = Article.find(params[:id])
    @like = @article.likes.find_by_user_id(current_user.id)
    if @like != nil then
      @like.destroy
    end
    respond_to do |format|               
      format.js
    end 
  end

  def like
    @article = Article.find(params[:id])
    if @article.likes.find_by_user_id(current_user.id) == nil then
      @like = @article.likes.create(like_params)
    end
    respond_to do |format|               
      format.js
    end 
  end

  private
  def article_params
    params.require(:article)[:user_id] = current_user.id
    params.require(:article).permit(:title, :text, :user_id)
  end

  private
  def like_params
    params[:user_id] = current_user.id
    params[:article_id] = params[:id]
    params.permit(:article_id, :user_id)
  end

end