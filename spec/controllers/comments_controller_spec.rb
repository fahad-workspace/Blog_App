require 'rails_helper'

describe CommentsController do

  describe 'After login as user' do

    login_user

    it 'creates a comment on an article' do
      @article = Article.create!(attributes_for(:article))
      expect do
        Comment.create!(attributes_for(:comment))
      end.to change(Comment, :count).by(1)
    end

    it 'creates a comment' do
      @article = Article.create!(attributes_for(:article))
      expect do
        post :create, comment: attributes_for(:comment), article_id: @article.id
      end.to change(Comment, :count).by(1)
    end

    it 'destroy a comment' do
      @article = Article.create!(attributes_for(:article))
      post :create, comment: attributes_for(:comment), article_id: @article.id
      expect do
        delete :destroy, {article_id: @article.to_param, id: @article.comments.last}
      end.to change(Comment, :count).by(-1)
    end

  end

end