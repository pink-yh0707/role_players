require 'rails_helper'

RSpec.describe User, type: :model do
  it "メールアドレス、ユーザーネーム、パスワードがあれば有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "メールアドレスがなければ無効である" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user).to_not be_valid
  end

  it "ユーザーネームがなければ無効である" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user).to_not be_valid
  end

  it "パスワードがなければ無効である" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user).to_not be_valid
  end

  it "重複したメールアドレスであるなら無効である" do
    FactoryBot.create(:user, :confirmed_at)
    user = FactoryBot.build(:user, user_name: "hogehoge2")
    expect(user).to_not be_valid
  end

  it "重複したユーザーネームであるなら無効である" do
    FactoryBot.create(:user, :confirmed_at)
    user = FactoryBot.build(:user, email: "hogehoge.test2@example.com")
    expect(user).to_not be_valid
  end
end
