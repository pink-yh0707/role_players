require 'rails_helper'

RSpec.describe User, type: :model do
  it "メールアドレス、ユーザーネーム、パスワードがあれば有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "メールアドレスがなければ無効である" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    # deviseを日本語訳したため
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "ユーザーネームがなければ無効である" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    # deviseを日本語訳したため
    expect(user.errors[:user_name]).to include("が入力されていません。")
  end

  it "パスワードがなければ無効である" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    # deviseを日本語訳したため
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "重複したメールアドレスであるなら無効である" do
    FactoryBot.create(:user, :confirmed_at)
    user = FactoryBot.build(:user, user_name: "hogehoge2")
    user.valid?
    # deviseを日本語訳したため
    expect(user.errors[:email]).to include("は既に使用されています。")
  end

  it "重複したユーザーネームであるなら無効である" do
    FactoryBot.create(:user, :confirmed_at)
    user = FactoryBot.build(:user, email: "hogehoge.test2@example.com")
    user.valid?
    # deviseを日本語訳したため
    expect(user.errors[:user_name]).to include("は既に使用されています。")
  end
end
