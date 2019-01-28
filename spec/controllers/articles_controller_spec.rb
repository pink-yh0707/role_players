require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before do
    @user = FactoryBot.create(:user, :confirmed_at)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    @user = FactoryBot.create(:article)

    it "returns http success" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      login @user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "記事を追加できること" do
      article_params = FactoryBot.attributes_for(:article)
      login @user

      expect {
        post :create, params: { article: article_params }
      }.to change(@user.articles, :count).by(1)
    end
  end

end
