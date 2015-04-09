require 'rails_helper'

describe ArticlesController do
  
  describe 'After login as user' do
    
    login_user
    
    it 'creates an article' do
      @user = subject.current_user
      @user.admin = false
      post :create, article: attributes_for(:article)
      expect(Article.count).to eq(1)
    end
    
  end
  
  describe 'After login as admin' do

    login_user
  
    it 'creates an user' do
      expect do
        user = FactoryGirl.create(:user)
        user.confirm!
      end.to change(User, :count).by(1)
    end
  
    it "should have a current_user" do
      expect(subject.current_user).not_to be_nil
    end
  
    describe 'Post create after login' do
  
      context 'with valid attributes' do
        it 'creates an article' do
          post :create, article: attributes_for(:article)
          expect(Article.count).to eq(1)
        end
  
        it 'redirects to the "show" action for the new article' do
          post :create, article: attributes_for(:article)
          expect(response).to redirect_to Article.first
        end
      end
  
      context 'with invalid attributes' do
        it 'does not create an article' do
          post :create, article: attributes_for(:article, text: nil)
          expect(Article.count).to eq(0)
        end
  
        it 're-renders the "new" view' do
          post :create, article: attributes_for(:article, text: nil)
          expect(response).to render_template :new
        end
      end
    end
  
    describe 'Delete an article' do
      context 'after creation' do
        it "destroys the requested article" do
          article = Article.create!(attributes_for(:article))
          expect do
            delete :destroy, {:id => article.to_param}
          end.to change(Article, :count).by(-1)
        end
      end
    end
  
    describe "GET index" do
      it "shows all articles" do
        article = Article.create!(attributes_for(:article))
        get :index
        expect(assigns(:articles)).to eq([article])
      end
    end
  
    describe "GET show" do
      it "shows the requested article" do
        article = Article.create!(attributes_for(:article))
        get :show, {:id => article.to_param}
        expect(assigns(:article)).to eq(article)
      end
    end
  
    describe "GET edit" do
      it "updates the requested article" do
        article = Article.create!(attributes_for(:article))
        get :update, {:id => article.to_param, :article => attributes_for(:article, title: "Title Changed")}
        expect(Article.first.title).to eq("Title Changed")
      end
    end
  
    describe "GET update" do
      it "does not update the requested article if title is blank" do
        article = Article.create!(attributes_for(:article))
        get :update, {:id => article.to_param, :article => attributes_for(:article, title: nil)}
        expect(Article.first.title).to eq(article.title)
      end
    end
  
    describe "GET edit" do
      it "does not update the requested article if title is blank" do
        article = Article.create!(attributes_for(:article))
        get :edit, {:id => article.to_param, :article => attributes_for(:article, title: nil)}
        expect(response).to render_template :edit
      end
    end
  
    it "Assigns a newly created article" do
      post :create, article: attributes_for(:article)
      expect(assigns(:article)).to be_a(Article)
      expect(assigns(:article)).to be_persisted
    end
  
    it "Redirects to the created article" do
      post :create, article: attributes_for(:article)
      expect(response).to redirect_to(Article.last)
    end
  
    it "assigns a newly created but unsaved article with invalid parameters" do
      allow_any_instance_of(Article).to receive(:save).and_return(false)
      post :create, article: attributes_for(:article, title: nil)
      expect(assigns(:article)).to be_a_new(Article)
    end
  
    it "re-renders the 'new' template with invalid parameters" do
      allow_any_instance_of(Article).to receive(:save).and_return(false)
      post :create, article: attributes_for(:article, title: nil)
      expect(response).to render_template("new")
    end
  
    it "assigns the requested article" do
      article = Article.create!(attributes_for(:article))
      put :update, {:id => article.to_param, :article => attributes_for(:article)}
      expect(assigns(:article)).to eq(article)
    end
  
    it "redirects to the article" do
      article = Article.create!(attributes_for(:article))
      put :update, {:id => article.to_param, :article => attributes_for(:article)}
      expect(response).to redirect_to(article)
    end
  
    describe "destroy article" do
      it "destroys the requested article" do
        article = Article.create!(attributes_for(:article))
        expect do
          delete :destroy, {:id => article.to_param}
        end.to change(Article, :count).by(-1)
      end
    end
  
    it "redirects to the posts list" do
      article = Article.create!(attributes_for(:article))
      delete :destroy, {:id => article.to_param}
      expect(response).to redirect_to(articles_url)
    end
  
    it "like an article" do
      article = Article.create!(attributes_for(:article))
      expect do
        patch :like, {:id => article.to_param, :format => 'js'}
      end.to change(article.likes, :count).by(1)
    end
  
    it "dislike an article" do
      article = Article.create!(attributes_for(:article))
      patch :like, {:id => article.to_param, :format => 'js'}
      expect do
        patch :dislike, {:id => article.to_param, :format => 'js'}
      end.to change(article.likes, :count).by(-1)
    end
  
  end

end