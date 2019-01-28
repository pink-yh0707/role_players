FactoryBot.define do
  factory :article do
    article_title "記事タイトル"
    content "紹介文"
    user_id 1

    association :player, factory: :player,
      player_name: "プレイヤー",
      team_name: "チーム",
      country: "国籍",
      position: "ポジション",
      height: "177",
      weight: "75"
  end
end
