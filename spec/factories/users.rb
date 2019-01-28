FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "hogehoge#{n}@example.com" }
    sequence(:user_name) { |n| "hogehoge#{n}" }
    password "foobarroleplayer7"

    trait :confirmed_at do
      confirmed_at Time.now
    end

    trait :create_article do
      association :article, factory: :article,
      article_title: "記事タイトル",
      content: "紹介文",
      user_id: "@user"

      association :player, factory: :player,
        player_name: "プレイヤー",
        team_name: "チーム",
        country: "国籍",
        position: "ポジション",
        height: "177",
        weight: "75"
    end
  end
end
