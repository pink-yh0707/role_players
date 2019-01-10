require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      user = FactoryBot.create(:user, :confirmed_at)

      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = FactoryBot.create(:user, :confirmed_at)

      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
