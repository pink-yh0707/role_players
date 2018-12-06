require 'rails_helper'

RSpec.describe "sign_ups", type: :system do
  include ActiveJob::TestHelper

  scenario "ユーザー登録" do
    visit root_path
    click_link "サインアップ"

    perform_enqueued_jobs do
      expect {
        fill_in "メールアドレス", with: "hogehoge@example.com"
        fill_in "ユーザーネーム", with: "hogehoge"
        fill_in "パスワード", with: "hogehoge7"
        fill_in "確認用パスワード", with: "hogehoge7"
        click_button "サインアップ"
      }.to change(User, :count).by 1

      expect(page).to \
        have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      expect(current_path).to eq root_path

      mail = ActionMailer::Base.deliveries.last

      aggregate_failures do
        expect(mail.to).to eq ["hogehoge@example.com"]
        expect(mail.from).to eq ["please-change-me-at-config-initializers-devise@example.com"]
        expect(mail.subject).to eq "Role Playersにようこそ!"
        expect(mail.body).to match "ようこそhogehogeさん!"
      end
    end
  end
end
