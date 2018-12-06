require 'rails_helper'

RSpec.describe User, type: :model do
  it "メールアドレス、ユーザーネーム、パスワードがあれば有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "値が入力されていない場合" do
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
  end

  describe "パスワードの値に不備がある場合" do
    it "8文字未満の場合" do
      user = FactoryBot.build(:user, password: "a" * 7)
      user.valid?
      # deviseを日本語訳したため
      expect(user.errors[:password]).to include("は有効でありません。")
    end

    it "33文字以上の場合" do
      user = FactoryBot.build(:user, password: "8" * 33)
      user.valid?
      # deviseを日本語訳したため
      expect(user.errors[:password]).to include("は有効でありません。")
    end

    it "英数字が含まれていない場合" do
      user = FactoryBot.build(:user, password: "a" * 10)
      user.valid?
      # deviseを日本語訳したため
      expect(user.errors[:password]).to include("は有効でありません。")

      user = FactoryBot.build(:user, password: 1 * 10)
      user.valid?
      # deviseを日本語訳したため
      expect(user.errors[:password]).to include("は有効でありません。")
    end
  end

  describe "重複した値がある場合" do
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
end
