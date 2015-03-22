class ArticlesController < ApplicationController

  before_action :authenticate_user!

  # http_basic_authenticate_with name: "fahad", password: "password", except: [:index, :show]

  def new
  end
  
  def index
    @articles = Article.all
    #@users = User.all
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
  def article_params
    params.require(:article)[:user_id] = current_user.id
    params.require(:article).permit(:title, :text, :user_id)
  end

end