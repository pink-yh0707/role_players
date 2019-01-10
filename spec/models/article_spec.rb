require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it "記事タイトル、紹介文があれば有効である" do
    article = @user.articles.build(content: "テスト紹介文", article_title: "テストタイトル")
    expect(article).to be_valid
  end

  describe "値が入力されていない場合" do
    it "記事タイトルがなければ無効である" do
      article = @user.articles.build(content: "テスト紹介文", article_title: nil)
      article.valid?
      expect(article.errors[:article_title]).to include("を入力してください")
    end

    it "自己紹介がなければ無効である" do
      article = @user.articles.build(content: nil, article_title: "テストタイトル")
      article.valid?
      expect(article.errors[:content]).to include("を入力してください")
    end
  end

  it "記事タイトルの値が50以内であれば有効" do
    article = @user.articles.build(content: "テスト紹介文", article_title: "a" * 50)
    expect(article).to be_valid
  end

  it "紹介文の値が10000文字以内であれば有効" do
    article = @user.articles.build(content: "a" * 10000, article_title: "テストタイトル")
    expect(article).to be_valid
  end

  describe "値に不備がある場合" do
    it "記事タイトルの値が51文字以上の場合" do
      article = @user.articles.build(content: "テスト紹介文", article_title: "a" * 51)
      article.valid?
      expect(article.errors[:article_title]).to include("は50文字以内で入力してください")
    end

    it "自己紹介の値が10001文字以上の場合" do
      article = @user.articles.build(content: "a" * 10001, article_title: "テストタイトル")
      article.valid?
      expect(article.errors[:content]).to include("は10000文字以内で入力してください")
    end
  end

  it "userを削除するとuserの作成したarticleも削除されること" do
    article = @user.articles.create(content: "テスト紹介文", article_title: "テストタイトル")
    expect{ @user.destroy }.to change{ Article.count }.by(-1)
  end
end
