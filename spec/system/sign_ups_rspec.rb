require 'rails_helper'

RSpec.describe "sign_ups", type: :system do
  include ActiveJob::TestHelper

  scenario "ユーザー登録" do
    visit root_path
    click_link "サインアップ"

    perform_enqueued_jobs do
      expect {
        fill_in "メールアドレス", with "hogehoge@example.com"
        fill_in "ユーザーネーム", with "hogehoge"
        fill_in "パスワード", with "foobar"
      }
    end
  end
end
