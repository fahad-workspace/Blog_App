# spec/controllers/articles_controller_spec.rb
require 'rails_helper'

describe ArticlesController do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates an article' do
        @user = "What to de here?"
        sign_in @user
        puts attributes_for(:article)
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
        post :create, article: attributes_for(:article, year: nil)
        expect(Article.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, article: attributes_for(:article, year: nil)
        expect(response).to render_template :new
      end
    end
  end
end