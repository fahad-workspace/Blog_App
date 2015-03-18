class ArticlesController < ApplicationController

  before_action :authenticate_user!

  http_basic_authenticate_with name: "fahad", password: "password", except: [:index, :show]

  def new
  end
  
  def index
    @articles = Article.all
    @users = User.all
  end
  
  def edit
    authenticate_user
    @article = Article.find(params[:id])
  end
  
  def update
    authenticate_user
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def create
    authenticate_user
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def destroy
    authenticate_user
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  def show
    authenticate_user
    @article = Article.find(params[:id])
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
  
  private
  def authenticate_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

end