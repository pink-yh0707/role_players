require 'rails_helper'

RSpec.describe "sign_ins", type: :system do
  let(:user) { FactoryBot.create(:user, :confirmed_at) }

  scenario "ユーザーのログインからログアウト" do
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    aggregate_failures do
      expect(page).to have_content "ログインしました。"
      expect(page).to have_content user.user_name
      expect(page).to have_content "ユーザー一覧"
      expect(page).to have_content "マイページ"
      expect(page).to have_content "ログアウト"
    end

    click_link "ログアウト"

    aggregate_failures do
      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_content "サインアップ"
      expect(page).to have_content "ログイン"
      expect(page).to_not have_content "ユーザー一覧"
      expect(page).to_not have_content "マイページ"
    end
  end
end
