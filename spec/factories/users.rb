FactoryBot.define do
  factory :user do
    email "hogehoge@example.com"
    user_name "hogehoge"
    password "foobar-roleplayers"

    trait :confirmed_at do
      confirmed_at Time.now
    end
  end
end
